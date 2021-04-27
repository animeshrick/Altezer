import 'dart:convert';

import 'package:http/http.dart' as http;


class MyClient extends http.BaseClient {
  final _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }

  @override
  Future<http.Response> post(Uri url,{Map<String,String>? headers,body,Encoding? encoding}) {
    try{
      return _client.post(url,headers: headers,body: body,encoding: encoding);
    }finally{
      _client.close();
    }
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    try {
      return _client.get(url, headers: headers).timeout(Duration(seconds: 60));
    } finally {
      _client.close();
    }
  }

}