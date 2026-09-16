class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.isSystemActive,
    required this.totalBusinessesCount,
  });

  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isSystemActive;
  final int totalBusinessesCount;

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    bool? isSystemActive,
    int? totalBusinessesCount,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        isSystemActive: isSystemActive ?? this.isSystemActive,
        totalBusinessesCount: totalBusinessesCount ?? this.totalBusinessesCount,
      );
}
