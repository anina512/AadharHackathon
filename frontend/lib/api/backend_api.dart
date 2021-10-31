import 'package:http/http.dart' as http;
import "dart:convert";
import 'dart:io';

class ChatApi {
  static const BaseUrl = "http://192.168.0.100:3000/";

  static Future upload(firebaseUrl) async {
    const url = BaseUrl + "image/";
    print(firebaseUrl);
    Map data = {'firebaseUrl': firebaseUrl};
    http.Response res = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print("====================");
    print(json.decode(res.body));
    print("====================");
    return json.decode(res.body);
  }
}

