import '../models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> fetchCategories();

  Future<CategoryModel> addCategory(CategoryModel category);

  Future<CategoryModel> updateCategory(CategoryModel category);

  Future<void> deleteCategory(String categoryId);

  Future<CategoryModel> toggleCategoryStatus(String categoryId);
}
