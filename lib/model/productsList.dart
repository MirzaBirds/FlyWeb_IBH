import 'package:flutter/material.dart';

class ProductListModel {
  String id;
  String title;
  String minPrice;
  String maxPrice;
  String image;

  ProductListModel({
    required this.id,
    required this.title,
    required this.minPrice,
    required this.maxPrice,
    required this.image,
  });
}

class ProductListModels {
  List<ProductListModel> _list = [];

  void addToList(ProductListModel item) {
    _list.add(item);
  }

  List<ProductListModel> get list {
    return [..._list];
  }

  void deleteItem(int index) {
    print('Index:- $index');
    _list.removeAt(index);
  }

  void printListDetails() {
    _list.forEach((element) {
      print(
          'id: ${element.id}, title: ${element.title}, minPrice: ${element.minPrice} and maxPrice: ${element.maxPrice}');
    });
  }
}
