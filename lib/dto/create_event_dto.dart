import 'dart:convert';
import 'dart:io';

import 'package:two_it_api/utils/utils.dart';

class CreateEventDto {
  String title;
  String eventLocationStatus;
  String locationTitle;
  String latitude;
  String longitude;
  String startDate;
  String endDate;
  String description;
  String ageRange;
  String availablePlace;
  String gender;
  String status;
  String categoryId;
  String isHandshake;
  List<String> tags;
  List<File> images;

  CreateEventDto({
    required this.title,
    required this.eventLocationStatus,
    required this.locationTitle,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.ageRange,
    required this.availablePlace,
    required this.gender,
    required this.status,
    required this.categoryId,
    required this.isHandshake,
    required this.tags,
    required this.images,
  });

  Map<String, String> toJson() {
    final Map<String, String> json = {};
    json['title'] = title;
    json['event_location_status'] = eventLocationStatus;
    json['location_title'] = locationTitle;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    json['start_date'] = startDate;
    json['end_date'] = endDate;
    json['description'] = description;
    json['age_range'] = ageRange;
    json['available_place'] = availablePlace;
    json['gender'] = gender;
    json['status'] = status;
    json['category_id'] = categoryId;
    json['is_handshake'] = isHandshake;
    json['tags'] = tags
        .map((e) => e.toString())
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');

    List<String> base64Image = [];
    for (int i = 0; i < images.length; i++) {
      String img = Utils.getImageBase64(images[i]);
      base64Image.add(img);
    }
    json['images[]'] = 'data:image/jpeg;base64,' +
        base64Image.toString().replaceAll('[', '').replaceAll(']', '');

    // List<String> base64Image = <String>[];
    // for (int i = 0; i < images.length; i++) {
    //   String img = Utils.getImageBase64(images[i]);
    //   base64Image.add(img);
    // }
    // json['images[]'] = base64Image;
    // print( base64Image.length);
    return json;
  }

  @override
  String toString() => const JsonEncoder.withIndent('  ').convert(toJson());
}
