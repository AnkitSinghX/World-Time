import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //Location name for UI
  String time; //Time in that location
  String flag; // URL to an asset flag icon
  String url; //Location URL for API End-Point
  bool isDaytime; //True or false if daytime or not

  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async {
    try {
      //Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);
      //print(datetime);
      //print(offset);
      //create DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now
          .add(Duration(hours: int.parse(offset), minutes: int.parse(offset2)));

      //Set Time Property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
