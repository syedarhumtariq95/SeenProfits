import 'package:flutter/material.dart';
import 'package:seen_profits/l10n/app_localizations.dart';

import '../../../../domain/models/business_listing_status.dart';
import '../../../../configs/router/routes.dart';
import '../../../generics/widgets/branding/app_logo.dart';
import '../../../generics/widgets/buttons/app_primary_button.dart';
import 'business_copy.dart';
import 'portal_screens.dart';

class _BusinessQuickAction {
  const _BusinessQuickAction(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({super.key});

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  BusinessListingStatus _status = BusinessListingStatus.approved;

  @override
  Widget build(BuildContext context) {
    final c = BusinessCopy.of(context);
    final isApproved = _status == BusinessListingStatus.approved;
    return Scaffold(
      drawer: _quickActionsDrawer(c, isApproved),
      appBar: AppBar(title: const AppLogo(size: 44), actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(
                context, CustomRouter.notificationsRouteName),
            icon: const Icon(Icons.notifications_none)),
        IconButton(
            onPressed: () => Navigator.pushNamed(
                context, CustomRouter.businessProfileRouteName),
            icon: const Icon(Icons.settings_outlined)),
        PopupMenuButton<BusinessListingStatus>(
            onSelected: (status) => setState(() => _status = status),
            itemBuilder: (_) => BusinessListingStatus.values
                .map((status) => PopupMenuItem(
                    value: status, child: Text(_statusLabel(c, status))))
                .toList())
      ]),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(20), children: [
        Text(c.dashboard,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        _dashboardStatus(c),
        if (_status != BusinessListingStatus.approved &&
            _status != BusinessListingStatus.noBusiness) ...[
          const SizedBox(height: 12),
          _statusFollowUp(c),
        ],
        const SizedBox(height: 16),
        if (_status == BusinessListingStatus.noBusiness) ...[
          Text(c.addBusinessHint),
          const SizedBox(height: 16),
          AppPrimaryButton(
              label: c.addBusiness,
              onPressed: () => Navigator.pushNamed(
                  context, CustomRouter.addBusinessRouteName))
        ] else ...[
          _SummaryCard(title: c.dashboardSummary, children: [
            const _InfoRow('ABC General Store', 'Retail'),
            _InfoRow(c.text('Age', 'عمر'), '4 years'),
            _InfoRow(c.amount, 'Rs. 500,000'),
            _InfoRow(c.verification, _statusLabel(c, _status))
          ]),
          if (isApproved) ...[
            const SizedBox(height: 18),
            Text(c.performance,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const _BusinessPerformanceChart(),
            const SizedBox(height: 12),
            _SummaryCard(title: c.investmentStatus, children: [
              _InfoRow(c.amount, 'Rs. 500,000'),
              _InfoRow(c.committed, 'Rs. 175,000'),
              _InfoRow(c.investorInterest, '3')
            ]),
            const SizedBox(height: 16),
            Text(c.activeRequests,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            Card(
                child: ListTile(
                    title: const Text('Ayesha Khan'),
                    subtitle: const Text('Rs. 100,000 · Pending'),
                    trailing: TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, CustomRouter.businessRequestsRouteName),
                        child: Text(c.viewAll))))
          ],
          const SizedBox(height: 16),
        ]
      ])),
    );
  }

  Widget _quickActionsDrawer(BusinessCopy c, bool isApproved) => Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 16),
                child: Text(c.text('Quick actions', 'فوری اقدامات'),
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              ..._actions(c, isApproved).map((action) => ListTile(
                    leading: Icon(action.icon),
                    title: Text(action.label),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, action.route);
                    },
                  )),
              ListTile(
                leading: const Icon(Icons.notifications_none),
                title: Text(c.notifications),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, CustomRouter.notificationsRouteName);
                },
              ),
            ],
          ),
        ),
      );

  Widget _dashboardStatus(BusinessCopy c) {
    final info = _status == BusinessListingStatus.approved
        ? c.text('Your business is approved and visible to investors.',
            'آپ کا کاروبار منظور شدہ ہے اور سرمایہ کاروں کو نظر آتا ہے۔')
        : _status == BusinessListingStatus.pending
            ? c.reviewHint
            : _status == BusinessListingStatus.rejected
                ? c.text(
                    'Review feedback is ready. Correct the listed issues and resubmit.',
                    'جائزہ فیڈ بیک تیار ہے۔ درج مسائل درست کر کے دوبارہ جمع کریں۔')
                : _status == BusinessListingStatus.changesRequired
                    ? c.text(
                        'Specific information needs updating before approval.',
                        'منظوری سے پہلے مخصوص معلومات کو اپ ڈیٹ کرنا ضروری ہے۔')
                    : _status == BusinessListingStatus.suspended
                        ? c.text(
                            'Your listing is hidden while a support issue is resolved.',
                            'سپورٹ کا مسئلہ حل ہونے تک آپ کی فہرست چھپی ہوئی ہے۔')
                        : c.addBusinessHint;
    return Card(
        child: ListTile(
            leading: const Icon(Icons.verified_outlined),
            title: Text(_statusLabel(c, _status),
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(info),
            trailing: _status == BusinessListingStatus.noBusiness
                ? null
                : IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                VerificationScreen(status: _status))),
                    icon: const Icon(Icons.arrow_forward))));
  }

  Widget _statusFollowUp(BusinessCopy c) {
    final isSuspended = _status == BusinessListingStatus.suspended;
    final title = isSuspended
        ? c.text(
            'Listing hidden from investors', 'فہرست سرمایہ کاروں سے پوشیدہ ہے')
        : _status == BusinessListingStatus.changesRequired
            ? c.text('Updates needed before approval',
                'منظوری سے پہلے تبدیلیاں درکار ہیں')
            : c.text('Next steps', 'اگلے مراحل');
    final detail = isSuspended
        ? c.text('Contact support for the reason and review process.',
            'وجہ اور جائزے کے عمل کے لیے سپورٹ سے رابطہ کریں۔')
        : _status == BusinessListingStatus.changesRequired
            ? c.text(
                'Review the highlighted business or financial information and resubmit the affected fields.',
                'نمایاں کاروباری یا مالی معلومات کا جائزہ لے کر متاثرہ شعبے دوبارہ جمع کریں۔')
            : c.text(
                'Review the feedback checklist, correct the issues, and resubmit for verification.',
                'رائے کی فہرست دیکھیں، مسائل درست کریں اور تصدیق کے لیے دوبارہ جمع کریں۔');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(detail),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            if (!isSuspended)
              OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                      context, CustomRouter.addBusinessRouteName),
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(_status == BusinessListingStatus.rejected
                      ? c.resubmit
                      : c.edit)),
            if (isSuspended || _status == BusinessListingStatus.rejected)
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.support_agent_outlined),
                  label: Text(c.contactSupport)),
          ])
        ]),
      ),
    );
  }

  List<_BusinessQuickAction> _actions(BusinessCopy c, bool isApproved) => [
        _BusinessQuickAction(
            c.edit, Icons.edit_outlined, CustomRouter.addBusinessRouteName),
        _BusinessQuickAction(c.verification, Icons.verified_outlined,
            CustomRouter.verificationRouteName),
        if (isApproved)
          _BusinessQuickAction(c.seekInvestment, Icons.trending_up,
              CustomRouter.seekInvestmentRouteName),
        _BusinessQuickAction(c.requests, Icons.handshake_outlined,
            CustomRouter.businessRequestsRouteName),
        _BusinessQuickAction(c.chats, Icons.chat_bubble_outline,
            CustomRouter.businessChatsRouteName),
        _BusinessQuickAction(c.profile, Icons.person_outline,
            CustomRouter.businessProfileRouteName)
      ];

  String _statusLabel(BusinessCopy c, BusinessListingStatus status) =>
      switch (status) {
        BusinessListingStatus.noBusiness => c.noBusiness,
        BusinessListingStatus.pending => c.pending,
        BusinessListingStatus.approved => c.approved,
        BusinessListingStatus.rejected => c.rejected,
        BusinessListingStatus.changesRequired => c.changesRequired,
        BusinessListingStatus.suspended => c.suspended
      };
}

class _BusinessPerformanceChart extends StatelessWidget {
  const _BusinessPerformanceChart();
  @override
  Widget build(BuildContext context) => SizedBox(
      height: 130,
      child: CustomPaint(
          painter: _HomeChartPainter(Theme.of(context).colorScheme.primary)));
}

class _HomeChartPainter extends CustomPainter {
  const _HomeChartPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(
        Path()
          ..moveTo(0, size.height * .78)
          ..lineTo(size.width * .2, size.height * .58)
          ..lineTo(size.width * .42, size.height * .68)
          ..lineTo(size.width * .65, size.height * .35)
          ..lineTo(size.width, size.height * .16),
        paint);
  }

  @override
  bool shouldRepaint(_HomeChartPainter oldDelegate) =>
      oldDelegate.color != color;
}

class InvestorHomeScreen extends StatelessWidget {
  const InvestorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: const AppLogo(size: 42)),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(20), children: [
        Text(l10n.welcomeInvestor,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        TextField(
            decoration: InputDecoration(
                labelText: l10n.searchBusinesses,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16)))),
        const SizedBox(height: 14),
        Wrap(
            spacing: 8,
            children: [
              l10n.all,
              l10n.retail,
              l10n.foodRestaurant,
              l10n.services
            ]
                .map((e) => FilterChip(
                    label: Text(e),
                    selected: e == l10n.all,
                    onSelected: (_) {}))
                .toList()),
        const SizedBox(height: 22),
        Text(l10n.featuredBusinesses,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _BusinessCard(
            title: l10n.abcGeneralStore,
            category: l10n.retail,
            age: l10n.twoYears,
            location: l10n.lahore,
            amount: l10n.rs100000,
            description: l10n.generalStoreDescription,
            onDetails: () => Navigator.of(context)
                .pushNamed(CustomRouter.businessDetailsRouteName)),
        _BusinessCard(
            title: l10n.xyzRestaurant,
            category: l10n.foodRestaurant,
            age: l10n.threeYears,
            location: l10n.islamabad,
            amount: l10n.rs500000,
            description: l10n.restaurantDescription,
            onDetails: () => Navigator.of(context)
                .pushNamed(CustomRouter.businessDetailsRouteName)),
      ])),
    );
  }
}

class BusinessDetailsScreen extends StatelessWidget {
  const BusinessDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.businessDetails)),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const AppLogo(size: 64),
          const SizedBox(height: 18),
          Text(l10n.abcGeneralStore,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _SummaryCard(title: l10n.businessOverview, children: [
            _InfoRow(l10n.category, l10n.retail),
            _InfoRow(l10n.businessAge, l10n.twoYears),
            _InfoRow(l10n.location, l10n.lahore),
            _InfoRow(l10n.rating, l10n.ratingValue),
            _InfoRow(l10n.verificationStatus, l10n.verified),
            _InfoRow(l10n.investmentRequired, l10n.rs100000)
          ]),
          const SizedBox(height: 16),
          Text(l10n.generalStoreDescription),
          const SizedBox(height: 12),
          Text(l10n.investmentPurpose,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          Text(l10n.inventoryExpansion),
          const SizedBox(height: 16),
          Container(
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(l10n.performanceGraphPlaceholder)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: AppPrimaryButton(
                    label: l10n.invest,
                    onPressed: () => showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                                title: Text(l10n.investmentConfirmation),
                                content: Text(l10n.staticInvestmentMessage),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(l10n.close))
                                ])))),
            const SizedBox(width: 12),
            Expanded(
                child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(CustomRouter.chatRouteName),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: Text(l10n.connect)))
          ])
        ]));
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _messages = <String>[];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.chatWithBusiness)),
        body: Column(children: [
          Expanded(
              child: ListView(padding: const EdgeInsets.all(16), children: [
            _bubble(l10n.helloInvestor, false, '10:30 AM'),
            _bubble(l10n.thanksForYourInterest, true, '10:31 AM'),
            ..._messages.map((m) => _bubble(m, false, 'Now'))
          ])),
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: l10n.typeMessage,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14))))),
                IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add(_controller.text.trim());
                          _controller.clear();
                        });
                      }
                    })
              ]))
        ]));
  }

  Widget _bubble(String text, bool mine, String timestamp) => Align(
      alignment: mine
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: mine
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(text),
            const SizedBox(height: 3),
            Text(timestamp, style: Theme.of(context).textTheme.labelSmall)
          ])));
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            ...children
          ])));
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600))
      ]));
}

class _BusinessCard extends StatelessWidget {
  const _BusinessCard(
      {required this.title,
      required this.category,
      required this.age,
      required this.location,
      required this.amount,
      required this.description,
      required this.onDetails});
  final String title, category, age, location, amount, description;
  final VoidCallback onDetails;
  @override
  Widget build(BuildContext context) => Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700))),
              const Icon(Icons.verified_rounded, color: Colors.green)
            ]),
            Text('$category • $age • $location'),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: Text(amount,
                      style: const TextStyle(fontWeight: FontWeight.w700))),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_rounded)),
              TextButton(
                  onPressed: onDetails,
                  child: Text(AppLocalizations.of(context)!.viewDetails))
            ])
          ])));
}
