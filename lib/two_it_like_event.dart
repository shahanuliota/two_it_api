import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:two_it_api/utils/utils.dart';

List<String> tokens = <String>[
  //'644|LXNKpQctoWrPqHIo8DprnllwKcEW2WThoX1qKLHq',
  '645|Ll59CXzZQmj8m2lCVVgd3hgiH4BOBfWdBuEU3gyQ',
  '646|UrEdWF1Wd6Kmw8iBgBD1k2FMjNDsx7Zjs0fCOeBk',
  '647|RF62SZuhWMueOKnzBArkwZTkceYXYkxMS3wY1Orp',
  '648|pNt8ClN2dPuVjlpsUhuJqiEwIqG3wka0DWdsf18M',
  '649|LhUCm8ooXEBcceCwobbC0EQXPPbfVgDOPBw7pjRw',
];


Future<void> apiCall(String token, String id) async {
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  http.Response response = await http.post(
    Uri.parse(
        'http://3.140.52.191/api/v1/event-match?event_id=$id&status=1&is_match=0&owner_id=57'),
    headers: headers,
  );

  // request.headers.addAll(headers);

  // http.StreamedResponse response = await request.send();

  print("Status code :=> ${response.statusCode}");

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

void main() async {
  // List<String> createdList = <String>[];
  // for (int i = 0; i < 3; i++) {
  //   String s = await createEvent(
  //     title: 'from dart script ${getRandomString(5)}',
  //     // token: '643|080JFMj4Y0urGZMknh0pgq2DTjNlIWaNCmTh00Iy',
  //     token: '645|Ll59CXzZQmj8m2lCVVgd3hgiH4BOBfWdBuEU3gyQ',
  //     img: imgList[i % imgList.length],
  //     // img: imgList[1],
  //   );
  //   if (s != (-1).toString()) {
  //     createdList.add(s);
  //   }
  // }

  // for (var eid in createdList) {
  //   for (int i = 0; i < tokens.length; i++) {
  //     apiCall(tokens[i], eid.toString());
  //     // await getProfileDetails(tokens[i]);
  //   }
  // }




  for(var token in tokens){
   await apiCall(token, '885');
  }



}
//
// Future<void> getProfileDetails(String token) async {
//   var headers = {
//     'Authorization': 'Bearer $token',
//     'Accept': 'application/json'
//   };
//   var response = await http.get(
//     Uri.parse('http://3.140.52.191/api/v1/profile-details/'),
//     headers: headers,
//   );
//
//   if (response.statusCode == 200) {
//     // print(response.body);
//     var phn = jsonDecode(response.body)['results']['user']['phone'];
//     var code = jsonDecode(response.body)['results']['user']['country_code'];
//     print("$code-$phn");
//   } else {
//     print(response.reasonPhrase);
//   }
// }

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


