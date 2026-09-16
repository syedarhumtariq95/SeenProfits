import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    final sidebar = DecoratedBox(
      decoration: const BoxDecoration(
        color: AdminThemeColors.sidebar,
        border: BorderDirectional(
          end: BorderSide(color: AdminThemeColors.outline),
        ),
      ),
      child: SizedBox(
        width: collapsed ? 84 : 272,
        child: Column(
          children: [
            SizedBox(
              height: 72,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                child: AdminBrandMark(compact: collapsed),
              ),
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

    return _NavigationTileContent(
      item: item,
      selected: selected,
      isDrawer: isDrawer,
      collapsed: collapsed,
      colorScheme: colorScheme,
    );
  }
}

class _NavigationTileContent extends StatefulWidget {
  const _NavigationTileContent({
    required this.item,
    required this.selected,
    required this.isDrawer,
    required this.collapsed,
    required this.colorScheme,
  });

  final AdminNavigationItem item;
  final bool selected;
  final bool isDrawer;
  final bool collapsed;
  final ColorScheme colorScheme;

  @override
  State<_NavigationTileContent> createState() => _NavigationTileContentState();
}

class _NavigationTileContentState extends State<_NavigationTileContent> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected;
    final foreground = active
        ? widget.colorScheme.primary
        : widget.colorScheme.onSurface.withOpacity(.78);
    final tile = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () {
          if (widget.isDrawer) {
            context.pop();
          }
          if (!active) {
            context.go(widget.item.route);
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: active
                ? AdminThemeColors.activeBackground
                : _hovered
                    ? widget.colorScheme.primary.withOpacity(.08)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: BorderDirectional(
              start: BorderSide(
                color: active ? widget.colorScheme.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(widget.item.icon, color: foreground),
              if (!widget.collapsed) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.item.label(context),
                    style: TextStyle(
                      color: foreground,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    final content = widget.collapsed
        ? Tooltip(message: widget.item.label(context), child: tile)
        : tile;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: content,
    );
  }
}
