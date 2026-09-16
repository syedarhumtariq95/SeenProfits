import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';

Future<void> showCategoryEditor(BuildContext context,
    {CategoryModel? category}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<CategoryBloc>(),
      child: CategoryEditorDialog(category: category),
    ),
  );
}

class CategoryEditorDialog extends StatefulWidget {
  const CategoryEditorDialog({super.key, this.category});

  final CategoryModel? category;

  @override
  State<CategoryEditorDialog> createState() => _CategoryEditorDialogState();
}

class _CategoryEditorDialogState extends State<CategoryEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iconController;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    _nameController = TextEditingController(text: category?.name);
    _descriptionController = TextEditingController(text: category?.description);
    _iconController = TextEditingController(text: category?.icon ?? 'category');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.category == null
            ? context.l10n.addCategory
            : context.l10n.editCategory),
        content: Form(
          key: _formKey,
          child: SizedBox(
            width: 460,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    InputDecoration(labelText: context.l10n.categoryName),
                validator: (value) => value == null || value.trim().isEmpty
                    ? context.l10n.requiredField
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: context.l10n.categoryDescription),
                maxLines: 3,
                validator: (value) => value == null || value.trim().isEmpty
                    ? context.l10n.requiredField
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _iconController,
                decoration:
                    InputDecoration(labelText: context.l10n.categoryIcon),
              ),
            ]),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.cancel)),
          FilledButton(
              onPressed: _submit, child: Text(context.l10n.saveChanges)),
        ],
      );

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final existing = widget.category;
    final category = CategoryModel(
      id: existing?.id ?? 'category-${DateTime.now().microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      icon: _iconController.text.trim().isEmpty
          ? 'category'
          : _iconController.text.trim(),
      isSystemActive: existing?.isSystemActive ?? true,
      totalBusinessesCount: existing?.totalBusinessesCount ?? 0,
    );
    context.read<CategoryBloc>().add(
        existing == null ? AddCategory(category) : UpdateCategory(category));
    Navigator.pop(context);
  }
}
