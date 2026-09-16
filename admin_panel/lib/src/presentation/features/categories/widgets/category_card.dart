import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import 'category_editor_dialog.dart';
import 'category_status_chip.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(child: Icon(_iconFor(category.icon))),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(category.name,
                      style: Theme.of(context).textTheme.titleMedium)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    showCategoryEditor(context, category: category);
                  }
                  if (value == 'delete') {
                    context
                        .read<CategoryBloc>()
                        .add(DeleteCategory(category.id));
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                      value: 'edit', child: Text(context.l10n.editCategory)),
                  PopupMenuItem(
                      value: 'delete',
                      child: Text(context.l10n.deleteCategory)),
                ],
              ),
            ]),
            const SizedBox(height: 16),
            Text(category.description,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                  child: Text(context.l10n
                      .businessesCount(category.totalBusinessesCount))),
              CategoryStatusChip(isActive: category.isSystemActive),
            ]),
            const Divider(height: 24),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(context.l10n.categoryStatus),
              value: category.isSystemActive,
              onChanged: (_) => context
                  .read<CategoryBloc>()
                  .add(ToggleCategoryStatus(category.id)),
            ),
          ]),
        ),
      );

  IconData _iconFor(String value) => switch (value) {
        'restaurant' => Icons.restaurant,
        'devices' => Icons.devices,
        'agriculture' => Icons.agriculture,
        'factory' => Icons.factory,
        _ => Icons.category,
      };
}
