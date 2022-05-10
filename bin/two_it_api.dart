import 'dart:convert';

import 'package:two_it_api/api/delete_all_events_for_user.dart';
import 'package:two_it_api/api/get_all_events_from_user.dart';
import 'package:two_it_api/api/login_user.dart';
import 'package:two_it_api/api/save_all_user_to_json.dart';
import 'package:two_it_api/two_it_api.dart';
import 'package:two_it_api/xl_to_json/xl_to_dart.dart';
import 'package:http/http.dart' as http;

/*

shawon1fb@gmail.com
cokplay0176@gmail.com
shahanul.iotait@gmail.com
joytish.iotait@gmail.com
shaiful.iotait@gmail.com
shawonhaque16@gmail.com
shawon11@gmail.com
sh@gmail.com
iota@iota.con
*/

List<String> emailList = <String>[
  "shawon1fb@gmail.com",
  "cokplay0176@gmail.com",
  "shahanul.iotait@gmail.com",
  "joytish.iotait@gmail.com",
  "shaiful.iotait@gmail.com",
// "shawonhaque16@gmail.com",
  "shawon11@gmail.com",
  "sh@gmail.com",
  "iota@iota.con",
];

void main() async {
  // xlTODart();
  try {
    // await saveAllUserToJson(emailList);
    // deleteAllEvent(email: 'shawon11@gmail.com');
    // getAllCreatedEvent(
    //     token: '4xRnmjZTX5P7qw3oQUyRPLtOQTrWvEbqeyqo4wHx', page: 1);

    // emailList.forEach((element) async {
    //   User user = await loginUserByEmail(email: element);
    // });
    // User user = await loginUserByEmail(email: 'cokplay0176@gmail.com');
    // allUsers();
    // String userToken = "819|4XK2RfONWr1JdK3OJdkcd4376jzN1bNMViUsVf4O";
    // int userId = await getProfileDetails(userToken);

    User user = User(
      email: 'cokplay0176@gmail.com',
      token: '1083|i8fKeOj4yJ7F0xQQl41pjG5iVXxY59jjGvYxb2vb',
      id: 55,
    );

    createEventWithUsers(
      userToken: user.token,
      userId: user.id.toString(),
    );
  } catch (e, t) {
    print(e);
    print(t);
  }
}

List<String> validTokens = <String>[];

void allUsers() async {
  List<User> users = await userListFromJson();

  for (var u in users) {
    validTokens.add(u.token);
  }

  // for (String token in validTokens) {
  //   await getProfileDetails(token);
  // }
}

void createEventWithUsers({
  required String userToken,
  required String userId,
}) async {
  try {
    allUsers();
    List<String> events = await twoItEventCreate(
      userToken: userToken,
      numberOfEvent: 6,
    );

    for (String event in events) {
      for (String token in validTokens) {
        likeEvents(eventId: event, ownerId: userId, token: token);
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> likeEvents({
  required String eventId,
  required String ownerId,
  required String token,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  http.Response response = await http.post(
    Uri.parse(
        'http://3.140.52.191/api/v1/event-match?event_id=$eventId&status=1&is_match=0&owner_id=$ownerId'),
    headers: headers,
  );
  print("Status code :=> ${response.statusCode}");

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

Future<int> getProfileDetails(String token) async {
  var headers = {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json'
  };
  var response = await http.get(
    Uri.parse('http://3.140.52.191/api/v1/profile-details/'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body)['results']['user']['email']);
    var phn = jsonDecode(response.body)['results']['user']['phone'];
    var code = jsonDecode(response.body)['results']['user']['country_code'];
    int id = jsonDecode(response.body)['results']['user']['id'];
    return id;
  } else {
    throw Exception('token invalid');
  }
}
