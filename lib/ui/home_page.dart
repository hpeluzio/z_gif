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

    if(_search == null)
      response = await http.get('https://api.giphy.com/v1/gifs/trending?api_key=0b5mJ9JEwsekheFFRqAewJrVdYR8PfS3&limit=20&rating=G');
    else
      response = await http.get('https://api.giphy.com/v1/gifs/search?api_key=0b5mJ9JEwsekheFFRqAewJrVdYR8PfS3&q=$_search&limit=20&offset=$_offset&rating=G&lang=en');
  
    return json.decode(response.body); 
  }

  @override
  void initState() {
    super.initState();

    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}