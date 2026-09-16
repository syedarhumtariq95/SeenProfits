import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/category_bloc.dart';
import 'bloc/category_event.dart';
import 'bloc/category_state.dart';
import 'widgets/category_grid.dart';
import 'widgets/category_search_bar.dart';
import 'widgets/category_shimmer.dart';

class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<CategoryBloc>()
          ..add(const FetchCategories()),
        child: const _CategoryManagementView(),
      );
}

class _CategoryManagementView extends StatelessWidget {
  const _CategoryManagementView();

  @override
  Widget build(BuildContext context) =>
      BlocListener<CategoryBloc, CategoryState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus &&
            current.actionStatus != CategoryActionStatus.loading,
        listener: (context, state) =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.actionStatus == CategoryActionStatus.success
              ? context.l10n.categoryActionSuccess
              : context.l10n.categoryActionFailed),
        )),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AdminPageHeader(title: context.l10n.categories),
            const SizedBox(height: 24),
            const CategorySearchBar(),
            const SizedBox(height: 20),
            Expanded(child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
              if (state.loadStatus == CategoryLoadStatus.loading ||
                  state.loadStatus == CategoryLoadStatus.initial) {
                return const CategoryShimmer();
              }
              if (state.loadStatus == CategoryLoadStatus.failure) {
                return _FailureMessage(
                    onRetry: () => context
                        .read<CategoryBloc>()
                        .add(const FetchCategories()));
              }
              if (state.visibleCategories.isEmpty) {
                return Center(child: Text(context.l10n.noCategoriesFound));
              }
              return SingleChildScrollView(
                  child: CategoryGrid(categories: state.visibleCategories));
            })),
          ]),
        ),
      );
}

class _FailureMessage extends StatelessWidget {
  const _FailureMessage({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(context.l10n.categoriesLoadFailed),
        const SizedBox(height: 12),
        OutlinedButton(onPressed: onRetry, child: Text(context.l10n.retry)),
      ]));
}
