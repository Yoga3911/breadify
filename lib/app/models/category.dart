class CategoryModel {
  CategoryModel({
    required this.name,
    required this.asset,
    this.isSelected = false,
  });

  final String name;
  final String asset;
  bool isSelected;
}
