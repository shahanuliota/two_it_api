import 'package:http/http.dart' as http;

import 'get_all_events_from_user.dart';
import 'login_user.dart';

Future<void> deleteAllEvent({required String email}) async {
  try {
    User user = await loginUserByEmail(email: email);
    List<EventListData> events =
        await getAllCreatedEvent(token: user.token, page: 1);

    int cnt = 0;

    print("events len => ${events.length}");

   // return;

    for (var event in events) {
      cnt++;
      if (cnt == 50) {
        await Future.delayed(Duration(seconds: 4));
      }
      deleteEvent(eventId: event.id!, token: user.token);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> deleteEvent({required String token, required int eventId}) async {
  try {
    Uri url = Uri.parse('http://3.140.52.191/api/v1/event-cancel/$eventId');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('not deleted event => $eventId ${response.body}');
    }
  } catch (e, t) {
    print(e);
    print(t);
  }
}
