import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<EventListData>> getAllCreatedEvent(
    {required String token, required int page}) async {
  try {
    List<EventListData> list = <EventListData>[];

    if (page == 0) {
      return list;
    }

    print('current page => $page');
    Uri url =
        Uri.parse('http://3.140.52.191/api/v1/event-list?type=4&page=$page');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> mp = json.decode(response.body);
      EventListResponseModel res = EventListResponseModel.fromJson(mp);

      for (EventListData data in res.results?.data ?? []) {
        list.add(data);
      }

      if (res.results?.nextPage != null) {
        List<EventListData> l = await getAllCreatedEvent(
            token: token, page: res.results?.nextPage ?? 0);
        list.addAll(l);
      }

      return list;
    } else {
      throw Exception('Request invalid');
    }
  } catch (e, t) {
    print(e);
    print(t);
    rethrow;
  }
}

class EventListResponseModel {
  bool? error;
  Results? results;
  String? message;
  int? nextPage;

  EventListResponseModel({
    this.error,
    this.results,
    this.message,
    this.nextPage,
  });

  EventListResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    results =
        json['results'] != null ? Results?.fromJson(json['results']) : null;
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (results != null) {
      data['results'] = results?.toJson();
    }
    return data;
  }
}

class Results {
  List<EventListData>? data;
  int? nextPage;

  Results({this.data, this.nextPage});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventListData>[];
      json['data'].forEach((v) {
        data?.add(EventListData.fromJson(v));
      });
    }
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    data['next_page'] = nextPage;
    return data;
  }
}

class EventListData {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  bool? handShakeMode;
  String? image;
  int? availablePlace;
  int? totalMembers;
  int? guestMembersAvailable;

  EventListData(
      {this.id,
      this.title,
      this.startDate,
      this.image,
      this.guestMembersAvailable});

  EventListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    handShakeMode = json['handshake_mode'];
    image = json['image'];
    availablePlace = json['available_place'];
    totalMembers = json['total_members'];
    guestMembersAvailable = json['guest_members_available'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['start_date'] = startDate;
    data['image'] = image;
    data['total_members'] = totalMembers;
    data['available_place'] = availablePlace;
    data['end_date'] = endDate;
    data['handshake_mode'] = handShakeMode;
    data['guest_members_available'] = guestMembersAvailable;
    return data;
  }
}
