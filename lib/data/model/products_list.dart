// To parse this JSON data, do
//
//     final productsList = productsListFromJson(jsonString);

import 'dart:convert';

ProductsList productsListFromJson(String str) => ProductsList.fromJson(json.decode(str));

String productsListToJson(ProductsList data) => json.encode(data.toJson());

class ProductsList {
  ProductsList({
    required this.success,
    required this.product,
  });

  bool success;
  List<Product> product;

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        success: json["success"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.desc,
    required this.category,
    required this.brand,
    required this.price,
    required this.mrp,
    required this.v,
  });

  String id;
  String image;
  String name;
  String desc;
  String category;
  String brand;
  double price;
  double mrp;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
        desc: json["desc"],
        category: json["category"],
        brand: json["brand"],
        price: json["price"]?.toDouble(),
        mrp: json["mrp"]?.toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "name": name,
        "desc": desc,
        "category": category,
        "brand": brand,
        "price": price,
        "mrp": mrp,
        "__v": v,
      };
}
