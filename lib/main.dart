import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const api_url = "https://api.hgbrasil.com/finance?key=cb44cfd2";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )
    ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(api_url);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double bitcoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Converter \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Loading...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25
                  ),
                  textAlign: TextAlign.center
                ),
              );
            default:
              if(snapshot.hasError) {
                return Center(
                  child: Text("Error :(",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25
                      ),
                      textAlign: TextAlign.center
                  ),
                );
              } else {
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                        color: Colors.amber,
                        size: 150,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Real",
                          labelStyle: TextStyle(
                            color: Colors.amber
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "R\$"
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dollar",
                            labelStyle: TextStyle(
                                color: Colors.amber
                            ),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Bitcoin",
                            labelStyle: TextStyle(
                                color: Colors.amber
                            ),
                            border: OutlineInputBorder(),
                            prefixText: "BTC"
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

