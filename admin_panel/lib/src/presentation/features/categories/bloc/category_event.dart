import '../../../../domain/models/category_model.dart';

sealed class CategoryEvent {
  const CategoryEvent();
}

class FetchCategories extends CategoryEvent {
  const FetchCategories();
}

class AddCategory extends CategoryEvent {
  const AddCategory(this.category);
  final CategoryModel category;
}

class UpdateCategory extends CategoryEvent {
  const UpdateCategory(this.category);
  final CategoryModel category;
}

class ToggleCategoryStatus extends CategoryEvent {
  const ToggleCategoryStatus(this.categoryId);
  final String categoryId;
}

class DeleteCategory extends CategoryEvent {
  const DeleteCategory(this.categoryId);
  final String categoryId;
}

class SearchCategories extends CategoryEvent {
  const SearchCategories(this.query);
  final String query;
}
