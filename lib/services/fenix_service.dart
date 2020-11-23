import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ist_study/models/fenix_user.dart';

class FenixService {
  static const String clientId = '1695915081466062';
  static const String clientSecret =
      'YiasGkJNIHRtYmU5JCnHREXVgEBI+8uZ3bPn2IgP2MiTAOIJmieTjxb0grsRnXdkYjafekoUlfCpWWuGOe6sHw==';
  static const String redirectUri = 'istudy://loginfenix.com';

  FlutterSecureStorage storage = FlutterSecureStorage();

  String getFenixLoginUrl() {
    return 'https://fenix.tecnico.ulisboa.pt/oauth/userdialog?client_id=$clientId&redirect_uri=$redirectUri';
  }

  Future<String> fetchAccessToken(String code) async {
    try {
      final url = 'https://fenix.tecnico.ulisboa.pt/oauth/access_token';
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      final Map<String, String> body = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'code': code,
        'grant_type': 'authorization_code',
      };
      Response response = await post(url, headers: headers, body: body);
      if (response.statusCode != 200) return null;
      dynamic responseJson = jsonDecode(response.body);
      print(responseJson['access_token']);
      storage.write(key: 'access_token', value: responseJson['access_token']);
      storage.write(key: 'refresh_token', value: responseJson['refresh_token']);
      storage.write(key: 'logged_in', value: "true");

      return responseJson['access_token'];
    } catch (e) {
      return null;
    }
  }

  Future<FenixUser> fetchPerson(String token, {bool retry}) async {
    print("2");

    try {
      final url =
          'https://fenix.tecnico.ulisboa.pt/api/fenix/v1/person?access_token=$token';
      final Map<String, String> headers = {
        'Accept': 'application/json',
      };

      Response response = await get(url, headers: headers);
      if (response.statusCode != 200) {
        if (retry ?? true) {
          refreshAccessToken()
              .then((token) => fetchPerson(token, retry: false));
        }
        print(jsonDecode(response.body).toString());
        return null;
      }
      dynamic responseJson = jsonDecode(response.body);
      print(responseJson["username"]);
      return FenixUser(user: responseJson);
    } catch (e) {
      return null;
    }
  }

  loginIn() async {
    const url =
        'https://fenix.tecnico.ulisboa.pt/oauth/userdialog?client_id=$clientId&redirect_uri=$redirectUri';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> refreshAccessToken() async {
    print("Ah");
    try {
      String refreshToken = await storage.read(key: 'refresh_token');
      final url = 'https://fenix.tecnico.ulisboa.pt/oauth/refresh_token';
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      final Map<String, String> body = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'refresh_token': refreshToken,
        'grant_type': 'refresh_token',
      };
      Response response = await post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        return null;
      }
      dynamic responseJson = jsonDecode(response.body);
      storage.write(key: 'access_token', value: responseJson['access_token']);

      return responseJson['access_token'];
    } catch (e) {
      return null;
    }
  }
}
