import '../../../../domain/models/category_model.dart';

enum CategoryLoadStatus { initial, loading, success, failure }

enum CategoryActionStatus { idle, loading, success, failure }

class CategoryState {
  const CategoryState({
    this.loadStatus = CategoryLoadStatus.initial,
    this.actionStatus = CategoryActionStatus.idle,
    this.categories = const [],
    this.query = '',
  });

  final CategoryLoadStatus loadStatus;
  final CategoryActionStatus actionStatus;
  final List<CategoryModel> categories;
  final String query;

  List<CategoryModel> get visibleCategories {
    final normalized = query.trim().toLowerCase();
    return categories
        .where((category) =>
            normalized.isEmpty ||
            category.name.toLowerCase().contains(normalized) ||
            category.description.toLowerCase().contains(normalized))
        .toList(growable: false);
  }

  CategoryState copyWith({
    CategoryLoadStatus? loadStatus,
    CategoryActionStatus? actionStatus,
    List<CategoryModel>? categories,
    String? query,
  }) =>
      CategoryState(
        loadStatus: loadStatus ?? this.loadStatus,
        actionStatus: actionStatus ?? this.actionStatus,
        categories: categories ?? this.categories,
        query: query ?? this.query,
      );
}
