class FavoriteModel {
  FavoriteModel({
    required this.id,
    required this.productId,
  });

  final String id;
  final String productId;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id_feed"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id_feed": id,
        "product_id": productId,
      };
}
