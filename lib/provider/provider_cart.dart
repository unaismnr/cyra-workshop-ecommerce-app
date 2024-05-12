import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final List<CartProductModel> _list = [];
  List<CartProductModel> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total = total + (item.price * item.qty);
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(
    int id,
    String name,
    double price,
    int qty,
    String imageUrl,
  ) {
    print(id);
    print(name);
    print(price);
    print(qty);
    print(imageUrl);
    final product = CartProductModel(
      id: id,
      name: name,
      price: price,
      qty: qty,
      imageUrl: imageUrl,
    );
    _list.add(product);
    notifyListeners();
  }

  void increment(CartProductModel product) {
    product.increment();
    notifyListeners();
  }

  void decrement(CartProductModel product) {
    product.decrement();
    notifyListeners();
  }

  void delete(CartProductModel product) {
    _list.remove(product);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }
}

class CartProductModel {
  int id;
  String name;
  double price;
  int qty = 1;
  String imageUrl;

  CartProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imageUrl,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        imageUrl: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "qty": qty,
        "image": imageUrl,
      };

  void increment() {
    qty++;
  }

  void decrement() {
    qty--;
  }
}
