import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/localization/admin_locale_cubit.dart';
import '../../configs/localization/localization_extensions.dart';
import '../../configs/router/admin_navigation.dart';
import '../../configs/theme/admin_theme_colors.dart';
import '../shared_widgets/admin_brand_mark.dart';
import 'admin_profile_menu.dart';

class AdminTopBar extends StatelessWidget {
  const AdminTopBar({
    super.key,
    required this.routeName,
    required this.usesDrawerNavigation,
    required this.sidebarCollapsed,
    required this.onMenuPressed,
  });

  final String routeName;
  final bool usesDrawerNavigation;
  final bool sidebarCollapsed;
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final route = adminNavigationItems
        .where((item) => item.route == routeName)
        .firstOrNull;
    final title = route?.label(context) ?? context.l10n.adminPortal;

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AdminThemeColors.sidebar,
        border: Border(bottom: BorderSide(color: AdminThemeColors.outline)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 650;
          return Row(
            children: [
              // Sirf mobile/tablet par (jab drawer mode active ho) Menu icon dikhega
              if (usesDrawerNavigation) ...[
                IconButton(
                  tooltip: context.l10n.toggleSidebar,
                  onPressed: onMenuPressed,
                  icon: const Icon(Icons.menu),
                ),
                const SizedBox(width: 8),
              ],
              if (usesDrawerNavigation && !isNarrow) ...[
                const AdminBrandMark(compact: true),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                tooltip: context.l10n.notificationsPlaceholder,
                onPressed: () {},
                icon: const Badge(
                  isLabelVisible: true,
                  label: Text('0'),
                  child: Icon(Icons.notifications_outlined),
                ),
              ),
              _LanguageMenu(),
              const SizedBox(width: 8),
              AdminProfileMenu(showDetails: !isNarrow),
            ],
          );
        },
      ),
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = context.select((AdminLocaleCubit cubit) => cubit.state);
    final l10n = context.l10n;
    return PopupMenuButton<String>(
      tooltip: l10n.language,
      icon: const Icon(Icons.language_outlined),
      onSelected: (languageCode) {
        context.read<AdminLocaleCubit>().changeLocale(Locale(languageCode));
      },
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          value: 'en',
          checked: locale.languageCode == 'en',
          child: Text(l10n.english),
        ),
        CheckedPopupMenuItem(
          value: 'ur',
          checked: locale.languageCode == 'ur',
          child: Text(l10n.urdu),
        ),
      ],
    );
  }
}