class ProductModel {
  int? id;
  int? catid;
  String? productname;
  double? price;
  String? image;
  String? description;

  ProductModel({
    this.id,
    this.catid,
    this.productname,
    this.price,
    this.image,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.parse(json["id"].toString()),
      catid: int.parse(json["catid"].toString()),
      productname: json["productname"].toString(),
      price: double.parse(json["price"].toString()),
      image: json["image"].toString(),
      description: json["description"].toString(),
    );
  }
}
