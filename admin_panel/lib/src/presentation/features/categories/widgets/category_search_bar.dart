import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import 'category_editor_dialog.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextField(
      onChanged: (value) =>
          context.read<CategoryBloc>().add(SearchCategories(value)),
      decoration: InputDecoration(
        hintText: context.l10n.searchCategories,
        prefixIcon: const Icon(Icons.search),
      ),
    );
    final addButton = FilledButton.icon(
      onPressed: () => showCategoryEditor(context),
      icon: const Icon(Icons.add),
      label: Text(context.l10n.addCategory),
    );
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth >=
              AdminBreakpoints.tablet
          ? Row(children: [
              Expanded(child: search),
              const SizedBox(width: 16),
              addButton
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              search,
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: addButton),
            ]),
    );
  }
}
