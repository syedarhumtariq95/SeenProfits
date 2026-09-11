import 'package:flutter/material.dart';

import '../../core/responsive/admin_breakpoints.dart';
import 'admin_sidebar.dart';
import 'admin_top_bar.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key, required this.routeName, required this.child});

  final String routeName;
  final Widget child;

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _sidebarCollapsed = false;

  void _openNavigation() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final usesDrawer =
            constraints.maxWidth < AdminBreakpoints.desktopNavigation;
        final topBar = AdminTopBar(
          routeName: widget.routeName,
          usesDrawerNavigation: usesDrawer,
          sidebarCollapsed: _sidebarCollapsed,
          onMenuPressed: usesDrawer
              ? _openNavigation
              : () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
        );

        if (usesDrawer) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: AdminSidebar(
              routeName: widget.routeName,
              isDrawer: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  topBar,
                  Expanded(child: _AdminContent(child: widget.child)),
                ],
              ),
            ),
          );
        }

        final sidebar = AdminSidebar(
          routeName: widget.routeName,
          collapsed: _sidebarCollapsed,
        );
        final content = Expanded(
          child: Column(
            children: [topBar, Expanded(child: _AdminContent(child: widget.child))],
          ),
        );
        final isRtl = Directionality.of(context) == TextDirection.rtl;

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: isRtl ? [content, sidebar] : [sidebar, content],
            ),
          ),
        );
      },
    );
  }
}

class _AdminContent extends StatelessWidget {
  const _AdminContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 560),
            child: child,
          ),
        ),
      ),
    );
  }
}
