import '../../domain/models/category_model.dart';
import '../../domain/repositories/category_repository.dart';

class MockCategoryRepositoryImpl implements CategoryRepository {
  MockCategoryRepositoryImpl({
    this.networkLatency = const Duration(milliseconds: 500),
  });

  final Duration networkLatency;

  final Map<String, CategoryModel> _categories = {
    'food': const CategoryModel(
      id: 'food',
      name: 'Food & Beverage',
      description: 'Restaurants, cafes, catering, and food products.',
      icon: 'restaurant',
      isSystemActive: true,
      totalBusinessesCount: 42,
    ),
    'technology': const CategoryModel(
      id: 'technology',
      name: 'Technology',
      description: 'Software, digital products, and technology services.',
      icon: 'devices',
      isSystemActive: true,
      totalBusinessesCount: 28,
    ),
    'agriculture': const CategoryModel(
      id: 'agriculture',
      name: 'Agriculture',
      description: 'Farming, livestock, and agricultural businesses.',
      icon: 'agriculture',
      isSystemActive: true,
      totalBusinessesCount: 19,
    ),
    'manufacturing': const CategoryModel(
      id: 'manufacturing',
      name: 'Manufacturing',
      description: 'Production, factories, and industrial businesses.',
      icon: 'factory',
      isSystemActive: false,
      totalBusinessesCount: 11,
    ),
  };

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    await _simulateNetworkRequest();
    return _categories.values.toList(growable: false);
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    await _simulateNetworkRequest();
    _categories[category.id] = category;
    return category;
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    await _simulateNetworkRequest();
    if (!_categories.containsKey(category.id)) {
      throw StateError('Category not found');
    }
    _categories[category.id] = category;
    return category;
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _simulateNetworkRequest();
    _categories.remove(categoryId);
  }

  @override
  Future<CategoryModel> toggleCategoryStatus(String categoryId) async {
    await _simulateNetworkRequest();
    final category = _categories[categoryId];
    if (category == null) throw StateError('Category not found');
    final updated = category.copyWith(isSystemActive: !category.isSystemActive);
    _categories[categoryId] = updated;
    return updated;
  }

  Future<void> _simulateNetworkRequest() =>
      Future<void>.delayed(networkLatency);
}
