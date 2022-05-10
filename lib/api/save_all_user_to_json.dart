import 'dart:convert';
import 'dart:io';

import 'login_user.dart';

Future<void> saveAllUserToJson(List<String> emails) async {
  try {
    List<Future<User>> loginTasks = <Future<User>>[];

    for (var email in emails) {
      var value = loginUserByEmail(email: email);
      loginTasks.add(value);
    }
    List<User> users = await Future.wait(loginTasks);
    print("user len => ${users.length}");

    String jsonString = jsonEncode(users.map((e) => e.toMap()).toList());

    print("--------json string --------");
    print(jsonString);

    File jsonFile = File('bin/user.json');

    jsonFile.writeAsStringSync(jsonString);
  } catch (e, t) {
    print(e);
    print(t);
  }
}

Future<List<User>> userListFromJson() async {
  try {
    File jsonFile = File('bin/user.json');
    String source = jsonFile.readAsStringSync();

    List l = json.decode(source);

    List<User> users = <User>[];
    for (var mp in l) {
      User u = User(
        id: mp['id'],
        email: mp['email'],
        token: mp['token'],
      );
      users.add(u);
    }

    return users;
  } catch (e, t) {
    print(e);
    print(t);
    rethrow;
  }
}
