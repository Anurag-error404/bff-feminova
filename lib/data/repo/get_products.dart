// https:// FProduct.harshitadeep.repl.co/api/product/all?category=Health&keyword=Vi&brand=Brand A&price[gt]=100&price[lt]=250

import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:feminova/data/model/products_list.dart';

class GetProducts {
  Future<ProductsList?> getAllProducts() async {
    try {
      final response = await Dio().get("https://FProduct.harshitadeep.repl.co/api/product/all");
      log(response.data.toString());
      final res = ProductsList.fromJson(response.data);
      log(res.product.length.toString());
      log("Success");
      return res;
    } catch (e) {
      log(e.toString());
    }
  }
}
