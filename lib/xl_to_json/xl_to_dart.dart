import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';

void xlTODart() {
  try {
    var file = "lib/xl_to_json/text.xlsx";
    var bytes = File(file).readAsBytesSync();
    Excel excel = Excel.decodeBytes(bytes);
    String tableKey = 'Sheet1';
    print(excel.tables.keys);

    for (var table in excel.tables.keys) {
      if (table == tableKey) {
        parseAndSaveToJson(table, excel);
      }
    }
  } catch (e, t) {
    print(e);
    print(t);
  }
}

void parseAndSaveToJson(String tableKey, Excel excel) {
  Map<String, String> engJson = {};
  Map<String, String> dutchJson = {};

  for (var row in excel.tables[tableKey]!.rows) {
    List<Data?> data = row;
    if (data.first != null) {
      String key = getKey(data.first!.value.toString());

      String value = data.first!.value.toString().trim();

      engJson[key] = value;
    }

    if (data.last != null) {
      String key = getKey(data.first!.value.toString());

      String value = data.last!.value.toString().trim();
      dutchJson[key] = value;
    }
  }

  engJson.remove('english');
  dutchJson.remove('english');

  print('----------------- english -------------');
  prettyPrinter(engJson);
  File enJsonFile = File('lib/xl_to_json/en.json');
  enJsonFile.writeAsStringSync(engJson.stringFi);

  print('----------------- dutch -------------');
  prettyPrinter(dutchJson);
  File duJsonFile = File('lib/xl_to_json/nl.json');
  duJsonFile.writeAsString(dutchJson.stringFi);
}

extension StringFi on Map<String, String> {
  String get stringFi => const JsonEncoder.withIndent('  ').convert(this);
}

void prettyPrinter(Map mp) {
  String st = const JsonEncoder.withIndent('  ').convert(mp);
  print(st);
}

String camelCase(String value) {
  final separatedWords =
      value.split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
  var newString = '';

  for (final word in separatedWords) {
    newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  return newString[0].toLowerCase() + newString.substring(1);
}

String getKey(String key) {
  key = key
      .trim()
      .replaceAll(' ', '_')
      .replaceAll('&', '_')
      .replaceAll('!', '')
      .replaceAll('?', '')
      .replaceAll('/', '_')
      .replaceAll('___', '_')
      .replaceAll('__', '_')
      .replaceAll(',', '')
      .replaceAll('.', '')
      .replaceAll('\n', '')
      .replaceAll(r'\', '')
      .replaceAll(r':', '')
      .replaceAll('>', '')
      .replaceAll("'", '')
      .replaceAll("’", '')
      .replaceAll("...", '')
      .replaceAll("…", '')
      .replaceAll('[-+.^:,]', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('“', '')
      .replaceAll('”', '')
  ;
  try{
    key = camelCase(key);
  }catch(e){
    print('error ------> $e $key');
  }
  if (key == 'continue') {
    key = 'continue_e';
  }

  return key;
}
