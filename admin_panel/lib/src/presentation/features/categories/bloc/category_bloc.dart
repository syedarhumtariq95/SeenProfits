import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/category_model.dart';
import '../../../../domain/repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this._repository) : super(const CategoryState()) {
    on<FetchCategories>(_onFetch);
    on<SearchCategories>(
        (event, emit) => emit(state.copyWith(query: event.query)));
    on<AddCategory>(
        (event, emit) => _save(event.category, _repository.addCategory, emit));
    on<UpdateCategory>((event, emit) =>
        _save(event.category, _repository.updateCategory, emit));
    on<ToggleCategoryStatus>(_onToggleStatus);
    on<DeleteCategory>(_onDelete);
  }

  final CategoryRepository _repository;

  Future<void> _onFetch(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(loadStatus: CategoryLoadStatus.loading));
    try {
      emit(state.copyWith(
        loadStatus: CategoryLoadStatus.success,
        categories: await _repository.fetchCategories(),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: CategoryLoadStatus.failure));
    }
  }

  Future<void> _save(
    CategoryModel category,
    Future<CategoryModel> Function(CategoryModel) action,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(actionStatus: CategoryActionStatus.loading));
    try {
      final saved = await action(category);
      final categories = [...state.categories];
      final index = categories.indexWhere((item) => item.id == saved.id);
      if (index == -1) {
        categories.add(saved);
      } else {
        categories[index] = saved;
      }
      emit(state.copyWith(
        actionStatus: CategoryActionStatus.success,
        categories: categories,
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: CategoryActionStatus.failure));
    }
  }

  Future<void> _onToggleStatus(
    ToggleCategoryStatus event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(actionStatus: CategoryActionStatus.loading));
    try {
      final updated = await _repository.toggleCategoryStatus(event.categoryId);
      emit(state.copyWith(
        actionStatus: CategoryActionStatus.success,
        categories: state.categories
            .map((category) => category.id == updated.id ? updated : category)
            .toList(growable: false),
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: CategoryActionStatus.failure));
    }
  }

  Future<void> _onDelete(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(actionStatus: CategoryActionStatus.loading));
    try {
      await _repository.deleteCategory(event.categoryId);
      emit(state.copyWith(
        actionStatus: CategoryActionStatus.success,
        categories: state.categories
            .where((category) => category.id != event.categoryId)
            .toList(growable: false),
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: CategoryActionStatus.failure));
    }
  }
}
