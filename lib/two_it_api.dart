import 'dart:io';

import 'package:faker_dart/faker_dart.dart';
import 'package:two_it_api/api/event_create_api.dart';
import 'package:two_it_api/images/image_list.dart';

import 'dto/create_event_dto.dart';

Future<List<String>> twoItEventCreate(
    {required String userToken, required int numberOfEvent}) async {
  try {
    List<File> imageFileList = <File>[];

    for (int i = 0; i < 1; i++) {
      File f = File(imgList[i % imgList.length]);
      imageFileList.add(f);
    }
    final Faker faker = Faker.instance;



    List<String> eventIdList = <String>[];
    List<Future<String>> tasks = <Future<String>>[];
    for (int i = 0; i < numberOfEvent; i++) {

      CreateEventDto dto = CreateEventDto(
        title: 'dart iota ${faker.name.firstName()}',
        eventLocationStatus: '1',
        locationTitle: faker.address.cityName(),
        latitude: '23.231792210911507',
        // '23.810331',
        longitude: '90.35705600000001',
        //'90.412521',
        startDate: '2022-02-15 11:41:00',
        endDate: '2023-02-15 11:41:00',
        description: faker.lorem.sentence(),
        //'description',
        ageRange: '18-35',
        availablePlace: '3',
        gender: 'male',
        status: '1',
        categoryId: '1',
        isHandshake: '0',
        tags: ['#1', '#2'],
        images: imageFileList,
      );

      tasks.add(createEvent(
        dto: dto,
        token: userToken,
      ));
    }

    eventIdList = await Future.wait(tasks);

    return eventIdList;
  } catch (e, t) {
    print(e);
    print(t);
    rethrow;
  }
}
