import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiBaseHelper {
  final String _baseUrl = 'https://ebehesht.tehran.ir:8080/api/v1';
  final String apiKey = 'F63CD7B1-EEDA-5D85-AAB1-B643E3E1D032';

  // Future<WeatherModel> getCityNameFromLocation(double latitude, double longitude) async {
  //   final url = '$_baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
  //   final res = await http.get (Uri.parse (url));
  //   if(res.statusCode != 200){
  //     throw FetchDataException ("unable to fetch weather data");
  //   }
  //   final weatherJson = json.decode (res.body);
  //   return WeatherModel.fromJson (weatherJson);
  // }
}