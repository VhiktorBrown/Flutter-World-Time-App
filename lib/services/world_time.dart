import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  late String location; //this is location that will be displayed in the UI
  late String time; // this displays the time in the UI as well
  late String flag; //this contains the URL for the flag of country
  late String url; //URL that will be appended to the Base URL

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    //connecting to the server and making the request
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map map = jsonDecode(response.body);

    //get Out the time from the response.
    String dateTime = map['datetime'];
    String offset = map['utc_offset'];

    //get the DateTime into a Date Object.
    DateTime now = DateTime.parse(dateTime);

    //cut out the + character in the offset value
    now = now.add(Duration(hours: int.parse(cutString(offset, 1, 3))));

    //convert the time to string and save in the time variable.
    time = now.toString();

  }

  String cutString(String word, int start, int end){
    return word.substring(start, end);
  }
}