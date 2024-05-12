class OrderDetailsModel {
  int id;
  String username;
  int totalamount;
  String paymentmethod;
  String date;
  List<Product>? products;

  OrderDetailsModel({
    required this.id,
    required this.username,
    required this.totalamount,
    required this.paymentmethod,
    required this.date,
    required this.products,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    print("id ====" + json["id"].toString());
    print("username ====" + json["username"].toString());
    print("totalamount ====" + json["totalamount"].toString());
    print("paymentmethod ====" + json["paymentmethod"].toString());
    print("date ====" + json["date"].toString());
    print("products ====" + json["products"].toString());
    return OrderDetailsModel(
      // id: json["id"],
      // username: json["username"],
      // totalamount: json["totalamount"],
      // paymentmethod: json["paymentmethod"],
      // date: DateTime.parse(json["date"]),
      // products: List<Product>.from(
      //     json["products"].map((x) => Product.fromJson(x))),'
      id: json["id"] == null ? null : json["id"],
      username: json["username"] == null ? null : json["username"],
      totalamount: json["totalamount"] == null ? null : json["totalamount"],
      paymentmethod:
          json["paymentmethod"] == null ? null : json["paymentmethod"],
      date: json["date"] == null ? null : json["date"],
      products: json["products"] == null
          ? null
          : List<Product>.from(
              json["products"].map((x) => Product.fromJson(x))),
    );
  }
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "username": username,
  //       "totalamount": totalamount,
  //       "paymentmethod": paymentmethod,
  //       "date": date.toIso8601String(),
  //       "products": List<dynamic>.from(products.map((x) => x.toJson())),
  //     };
}

class Product {
  String productname;
  int price;
  String image;
  int quantity;

  Product({
    required this.productname,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productname: json["productname"] == null ? null : json["productname"],
        price: json["price"] == null ? null : json["price"],
        image: json["image"] == null ? null : json["image"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  // Map<String, dynamic> toJson() {
  //   print(productname);
  //   print(price);
  //   print(image);
  //   print(quantity);
  //   return {
  //     "productname": productname,
  //     "price": price,
  //     "image": image,
  //     "quantity": quantity,
  //   };
  // }
}
