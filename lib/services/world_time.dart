import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location;  // location name for UI
  late String time; // time in that location
  late String flag; // URL to asset flag icon
  late String url;  // location URL for API endpoint
  late bool isDayTime;  // true or false, if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async{

    await Future.delayed(const Duration(seconds: 2), () {});

    try {

      // make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data =jsonDecode(response.body);

      // get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}

