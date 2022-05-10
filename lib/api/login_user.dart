import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<User> loginUserByEmail({required String email}) async {
  try {
    await otpSend(email: email);
    User user = await matchOtp(email: email);
    print(user.toString());
    return user;
  } catch (e, t) {
    print(e.toString());
    print(t.toString());
    rethrow;
  }
}

Future<void> otpSend({required String email}) async {
  try {
    var headers = <String, String>{};
    Uri url = Uri.parse('http://3.140.52.191/api/v1/otp-mail-send');
    http.Response response = await http.post(
      url,
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<User> matchOtp({required String email}) async {
  try {
    var headers = <String, String>{};

    Uri url = Uri.parse('http://3.140.52.191/api/v1/otp-mail-verify');

    print("Enter your Otp?");
    // Reading name of the Geek
    String? otpString = stdin.readLineSync();

    // Printing the name
    print("Otp:=>, $otpString!\n");

    http.Response response = await http.post(
      url,
      body: {
        'email': email,
        'otp': otpString ?? '18786',
        'type': 'login',
        'device_id': 'iwioeioioehioheoihoiehoiheooieoi',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> mp = json.decode(response.body);
      String token = mp['results']['token'];
      String email = mp['results']['user']['email'];
      int id = mp['results']['user']['id'];
      return User(email: email, token: token, id: id);
    } else {
      throw Exception('Otp not match');
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}

class User {
  String email;
  String token;
  int id;

  User({
    required this.email,
    required this.token,
    required this.id,
  });

  Map<String, dynamic> toMap() => {'email': email, 'token': token, 'id': id};

  @override
  String toString() {
    return json.encode(toMap());
  }
}
