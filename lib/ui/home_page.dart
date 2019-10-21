import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;

  Future<Map> _getGifs() async {
    http.Response response;
    int _offset;

    if (_search == null)
      response = await http.get(
          'https://api.giphy.com/v1/gifs/trending?api_key=0b5mJ9JEwsekheFFRqAewJrVdYR8PfS3&limit=20&rating=G');
    else
      response = await http.get(
          'https://api.giphy.com/v1/gifs/search?api_key=0b5mJ9JEwsekheFFRqAewJrVdYR8PfS3&q=$_search&limit=20&offset=$_offset&rating=G&lang=en');

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    // _getGifs().then((map) {
    //   print(map);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Pesquise aqui',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5,
                      ),
                    );
                  default:
                    if(snapshot.hasError) return Container();
                    else _createGifTable(context, snapshot);
                } 
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    
  }

}
