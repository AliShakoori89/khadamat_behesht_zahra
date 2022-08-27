import 'package:http/http.dart' as http;


class ApiBaseHelper {
  final String _baseUrl = 'https://ebehesht.tehran.ir:8080/api/v1';
  final String apiKey = 'F63CD7B1-EEDA-5D85-AAB1-B643E3E1D032';

  Future<dynamic> get(String url) async {
    http.Response response = await http.get(Uri.parse(_baseUrl + url),
        headers: {"APIKey": apiKey});

    print(response.body);
    print('+++++++++++++++++++++++++++++++++++++++++++++'+response.toString());

    return response;
  }
}