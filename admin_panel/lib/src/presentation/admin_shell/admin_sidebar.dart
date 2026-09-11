import 'package:flutter/material.dart';

import '../../configs/dependency_injection/dependency_injection.dart';
import '../../configs/localization/localization_extensions.dart';
import '../../configs/router/admin_navigation.dart';
import '../../configs/theme/admin_theme_colors.dart';
import '../../core/auth/admin_session.dart';
import '../shared_widgets/admin_brand_mark.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({
    super.key,
    required this.routeName,
    this.isDrawer = false,
    this.collapsed = false,
  });

  final String routeName;
  final bool isDrawer;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final session = AdminDependencyInjection.get<AdminSession>();
    final navigationItems = adminNavigationItems
        .where((item) => session.can(item.permission))
        .toList(growable: false);

    final sidebar = ColoredBox(
      color: AdminThemeColors.sidebar,
      child: SizedBox(
        width: collapsed ? 84 : 272,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20),
              child: AdminBrandMark(compact: collapsed),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                children: [
                  for (final item in navigationItems)
                    _NavigationTile(
                      item: item,
                      selected: item.route == routeName,
                      isDrawer: isDrawer,
                      collapsed: collapsed,
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: collapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      child: Icon(Icons.admin_panel_settings_outlined)),
                  if (!collapsed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.l10n.administrator),
                          Text(
                            context.l10n.superAdmin,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return isDrawer ? Drawer(child: sidebar) : sidebar;
  }
}

class _NavigationTile extends StatelessWidget {
  const _NavigationTile({
    required this.item,
    required this.selected,
    required this.isDrawer,
    required this.collapsed,
  });

  final AdminNavigationItem item;
  final bool selected;
  final bool isDrawer;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final tile = ListTile(
      selected: selected,
      selectedTileColor: colorScheme.primary.withOpacity(0.18),
      selectedColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(item.icon),
      title: collapsed ? null : Text(item.label(context)),
      onTap: () {
        if (isDrawer) {
          Navigator.of(context).pop();
        }
        if (!selected) {
          Navigator.of(context).pushReplacementNamed(item.route);
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: collapsed
          ? Tooltip(
        message: item.label(context),
        child: tile,
      )
          : tile,
    );
  }
}