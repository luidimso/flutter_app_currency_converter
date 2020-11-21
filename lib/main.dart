import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const api_url = "https://api.hgbrasil.com/finance?key=cb44cfd2";

void main() async {
  http.Response response = await http.get(api_url);
  print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(
    home: Container(),
  ));
}
