import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:altezar/utils/const.dart';
import 'package:altezar/models/getGoods.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();

  Networkcall._internal();

  factory Networkcall() {
    return networkcall;
  }

  // -------------- goods ------------------
  Future<List<Goods_data>> getGoods() async {
    //if (_formkey.currentState.validate()) {
    var url =
        'https://laravel.gowebbidemo.com/122282/public/api/v1/user/get-goods';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      var myjson = jsonDecode(response.body);
      Goods_Model model = Goods_Model.fromJson(myjson);
      if (model.status == 'success') {
        return model.dataList;
      } else
        throw 'No data';
    } else
      throw 'Error';
    // }
  }
}

Networkcall networkcallService = new Networkcall();
