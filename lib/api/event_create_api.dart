import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:two_it_api/dto/create_event_dto.dart';


Future<String> createEvent({required CreateEventDto dto, token}) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://3.140.52.191/api/v1/event-create'));

    request.fields.addAll(dto.toJson());

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("status :=> ${response.statusCode}");
    if (response.statusCode == 200) {
      String js = await response.stream.bytesToString();
      Map<String, dynamic> j = json.decode(js);
      print(j);
      return j['results']['event_id'].toString();
    } else {
      throw Exception('Event Not Created');
    }
  } catch (e) {
    print(e);
    throw Exception('Event Not Created');
  }
}


