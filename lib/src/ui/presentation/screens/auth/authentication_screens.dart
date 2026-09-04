import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import '../../../../configs/router/routes.dart';
import '../../../generics/widgets/branding/app_logo.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';
import 'auth_entry_screen.dart';

enum AuthenticationPage { login, register, forgotPassword, resetPassword, otp }

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    super.key,
    this.role,
    required this.page,
  });

  final SeenProfitsRole? role;
  final AuthenticationPage page;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _secondsRemaining = 30;
  Timer? _timer;

  bool get _isBusiness => widget.role == SeenProfitsRole.business;
  bool get _isGeneric => widget.role == null;

  String get _loginRoute => _isGeneric
      ? CustomRouter.loginRouteName
      : _isBusiness
          ? CustomRouter.businessLoginRouteName
          : CustomRouter.investorLoginRouteName;
  String get _registerRoute => _isGeneric
      ? CustomRouter.registerRouteName
      : _isBusiness
          ? CustomRouter.businessRegisterRouteName
          : CustomRouter.investorRegisterRouteName;
  String get _forgotRoute => _isGeneric
      ? CustomRouter.forgotPasswordRouteName
      : _isBusiness
          ? CustomRouter.businessForgotPasswordRouteName
          : CustomRouter.investorForgotPasswordRouteName;
  String get _resetRoute => _isGeneric
      ? CustomRouter.resetPasswordRouteName
      : _isBusiness
          ? CustomRouter.businessResetPasswordRouteName
          : CustomRouter.investorResetPasswordRouteName;
  String get _otpRoute => _isGeneric
      ? CustomRouter.otpRouteName
      : _isBusiness
          ? CustomRouter.businessOtpRouteName
          : CustomRouter.investorOtpRouteName;

  @override
  void initState() {
    super.initState();
    if (widget.page == AuthenticationPage.otp) _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        if (mounted) setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in [
      _nameController,
      _emailController,
      _phoneController,
      _cnicController,
      _passwordController,
      _confirmPasswordController,
      _otpController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    switch (widget.page) {
      case AuthenticationPage.login:
      case AuthenticationPage.otp:
        Navigator.of(context).pushNamed(CustomRouter.roleSelectionRouteName);
      case AuthenticationPage.register:
        Navigator.of(context).pushNamed(_otpRoute);
      case AuthenticationPage.forgotPassword:
        Navigator.of(context).pushNamed(_resetRoute);
      case AuthenticationPage.resetPassword:
        Navigator.of(context).pushNamed(_loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLogin = widget.page == AuthenticationPage.login;
    final isRegister = widget.page == AuthenticationPage.register;
    final isOtp = widget.page == AuthenticationPage.otp;
    final isForgot = widget.page == AuthenticationPage.forgotPassword;
    final title = isLogin
        ? (_isGeneric
            ? l10n.login
            : (_isBusiness ? l10n.loginBusiness : l10n.loginInvestor))
        : isRegister
            ? (_isGeneric
                ? l10n.register
                : (_isBusiness ? l10n.registerBusiness : l10n.registerInvestor))
            : isOtp
                ? l10n.otp
                : isForgot
                    ? l10n.forgotPassword
                    : l10n.resetPassword;
    final subtitle = isLogin
        ? l10n.signInToContinue
        : isRegister
            ? l10n.createYourAccount
            : isOtp
                ? l10n.otpDescription(
                    '+92 ${_phoneController.text.isEmpty ? '3XX XXXXXXX' : _phoneController.text}')
                : isForgot
                    ? l10n.forgotPasswordDescription
                    : l10n.resetPasswordDescription;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: AppLogo(size: 82)),
                  const SizedBox(height: 28),
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.5)),
                  const SizedBox(height: 28),
                  if (isLogin) ..._loginFields(l10n),
                  if (isRegister) ..._registerFields(l10n),
                  if (isForgot) ..._forgotFields(l10n),
                  if (widget.page == AuthenticationPage.resetPassword)
                    ..._resetFields(l10n),
                  if (isOtp) ..._otpFields(l10n),
                  const SizedBox(height: 28),
                  AppPrimaryButton(
                    label: isLogin
                        ? l10n.login
                        : isRegister
                            ? l10n.register
                            : isOtp
                                ? l10n.verify
                                : isForgot
                                    ? l10n.continueLabel
                                    : l10n.resetPassword,
                    icon: isOtp ? Icons.verified_outlined : null,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 16),
                  _navigation(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _loginFields(AppLocalizations l10n) => [
        _field(
            controller: _emailController,
            label: l10n.emailOrPhone,
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _passwordField(
            controller: _passwordController,
            label: l10n.password,
            obscure: _obscurePassword,
            onToggle: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            l10n: l10n),
        Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
                onPressed: () => Navigator.of(context).pushNamed(_forgotRoute),
                child: Text(l10n.forgotPassword))),
      ];

  List<Widget> _registerFields(AppLocalizations l10n) => [
        _field(
            controller: _nameController,
            label: l10n.fullName,
            icon: Icons.person_outline_rounded),
        const SizedBox(height: 16),
        _field(
            controller: _emailController,
            label: l10n.email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _phoneField(l10n),
        const SizedBox(height: 16),
        _field(
            controller: _cnicController,
            label: l10n.cnic,
            icon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [CnicInputFormatter()]),
        const SizedBox(height: 16),
        _passwordField(
            controller: _passwordController,
            label: l10n.password,
            obscure: _obscurePassword,
            onToggle: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            l10n: l10n),
        const SizedBox(height: 16),
        _passwordField(
            controller: _confirmPasswordController,
            label: l10n.confirmPassword,
            obscure: _obscureConfirmPassword,
            onToggle: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword),
            l10n: l10n),
        const SizedBox(height: 12),
        Text(l10n.registrationPrivacyHint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ];

  List<Widget> _forgotFields(AppLocalizations l10n) => [
        _field(
            controller: _emailController,
            label: l10n.emailOrPhone,
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress)
      ];

  List<Widget> _resetFields(AppLocalizations l10n) => [
        _passwordField(
            controller: _passwordController,
            label: l10n.newPassword,
            obscure: _obscurePassword,
            onToggle: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            l10n: l10n),
        const SizedBox(height: 16),
        _passwordField(
            controller: _confirmPasswordController,
            label: l10n.confirmPassword,
            obscure: _obscureConfirmPassword,
            onToggle: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword),
            l10n: l10n),
      ];

  List<Widget> _otpFields(AppLocalizations l10n) => [
        Directionality(
            textDirection: TextDirection.ltr,
            child: _field(
                controller: _otpController,
                label: l10n.otp,
                icon: Icons.password_rounded,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly])),
        const SizedBox(height: 8),
        Align(
            alignment: AlignmentDirectional.center,
            child: _secondsRemaining > 0
                ? Text(l10n.otpExpiresIn(_secondsRemaining.toString()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant))
                : TextButton(
                    onPressed: _startTimer, child: Text(l10n.resendOtp))),
      ];

  Widget _phoneField(AppLocalizations l10n) => _field(
          controller: _phoneController,
          label: l10n.phoneNumber,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          prefix: const Padding(
              padding: EdgeInsetsDirectional.only(start: 12, end: 8),
              child: Text('+92')),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ]);

  Widget _passwordField(
          {required TextEditingController controller,
          required String label,
          required bool obscure,
          required VoidCallback onToggle,
          required AppLocalizations l10n}) =>
      _field(
          controller: controller,
          label: label,
          icon: Icons.lock_outline_rounded,
          obscureText: obscure,
          suffix: IconButton(
              tooltip: obscure ? l10n.showPassword : l10n.hidePassword,
              onPressed: onToggle,
              icon: Icon(obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined)));

  Widget _field(
          {required TextEditingController controller,
          required String label,
          required IconData icon,
          TextInputType? keyboardType,
          List<TextInputFormatter>? inputFormatters,
          Widget? prefix,
          Widget? suffix,
          bool obscureText = false,
          int? maxLength,
          TextAlign? textAlign}) =>
      TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          maxLength: maxLength,
          textAlign: textAlign ?? TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
              prefix: prefix,
              suffixIcon: suffix,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 17)));

  Widget _navigation(AppLocalizations l10n) {
    if (widget.page == AuthenticationPage.login) {
      return _navText(l10n.dontHaveAccount, l10n.createAccount, _registerRoute);
    }
    if (widget.page == AuthenticationPage.register) {
      return _navText(l10n.alreadyHaveAccount, l10n.login, _loginRoute);
    }
    return Center(
        child: TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded),
            label: Text(l10n.backToLogin)));
  }

  Widget _navText(String lead, String action, String route) => Center(
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        Text(lead),
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed(route),
            child: Text(action))
      ]));
}

class CnicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final digits =
        rawDigits.length > 13 ? rawDigits.substring(0, 13) : rawDigits;
    final buffer = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      if (index == 5 || index == 12) {
        buffer.write('-');
      }
      buffer.write(digits[index]);
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length));
  }
}
