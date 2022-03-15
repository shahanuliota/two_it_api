import 'dart:convert';

import 'package:two_it_api/api/delete_all_events_for_user.dart';
import 'package:two_it_api/api/get_all_events_from_user.dart';
import 'package:two_it_api/api/login_user.dart';
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


*/
void main() async {
  // xlTODart();
  try {

    deleteAllEvent(email: 'shawon11@gmail.com');
    // getAllCreatedEvent(
    //     token: '4xRnmjZTX5P7qw3oQUyRPLtOQTrWvEbqeyqo4wHx', page: 1);
    // loginUserByEmail(email: 'shaiful.iotait@gmail.com');
    // allUsers();
    // String userToken = "819|4XK2RfONWr1JdK3OJdkcd4376jzN1bNMViUsVf4O";
    // int userId = await getProfileDetails(userToken);
    // createEventWithUsers(userToken: userToken, userId: userId.toString());
  } catch (e, t) {
    print(e);
    print(t);
  }
}

List<String> validTokens = <String>[
  "795|3B0f2yYj5gIablG2YfzvvfPkIz2e4kjoXo4O3RCp",
  "796|EZIfpxuPZ11bHrZWITs3uINd3esbSFgHsehFu0Ys",
  "797|nIA2llKrAfi51xDms5hyd99ysHe3Ydg1Vm5XY4xV",
  '798|uTyu3UjGD6Ranps3IIRWnHvJLOkSVeFHHybJoVpY',
  "818|4xRnmjZTX5P7qw3oQUyRPLtOQTrWvEbqeyqo4wHx",
  "811|aINCDVBboI2GgzAFB87PyCyDtVvvRFdKcLoDvhrk",
];

void allUsers() async {
  for (String token in validTokens) {
    await getProfileDetails(token);
  }
}

void createEventWithUsers({
  required String userToken,
  required String userId,
}) async {
  try {
    List<String> events = await twoItEventCreate(
      userToken: userToken,
      numberOfEvent: 1,
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
