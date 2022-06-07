import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String cutString(String word, int start, int end){
    return word.substring(start, end);
  }

  void getTime() async{
    //connecting to the server and making the request
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/Africa/Lagos'));
    Map map = jsonDecode(response.body);
    //print(map);

    String dateTime = map['datetime'];
    String offset = map['utc_offset'];
    //
    // print(dateTime);
    // print(offset);

    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(cutString(offset, 1, 3))));

    print(now);
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Loading screen'),
    );
  }
}
