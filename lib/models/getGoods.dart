import 'package:flutter/material.dart';

class Goods_Model {
  final String status;
  final List<Goods_data> dataList;

  Goods_Model({required this.status, required this.dataList});

  factory Goods_Model.fromJson(Map<String, dynamic> myjson) {
    return Goods_Model(
        status: myjson['status'],
        dataList: (myjson['data'] as List)
            .map((e) => Goods_data.fromJson(e))
            .toList());
  }
}

class Goods_data {
  final int id;
  final String name, image, url;

  Goods_data(
      {required this.id,
      required this.name,
      required this.image,
      required this.url});

  factory Goods_data.fromJson(Map<String, dynamic> myjson) {
    return Goods_data(
        id: myjson['id'],
        name: myjson['name'],
        image: myjson['image'],
        url: myjson['url']);
  }
}
