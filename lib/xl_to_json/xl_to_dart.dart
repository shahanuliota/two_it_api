import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';

void main() {
  xlTODart();
}

void xlTODart() {
  try {
    var file = "lib/xl_to_json/translations World tour audio guide.xlsx";
    var bytes = File(file).readAsBytesSync();
    Excel excel = Excel.decodeBytes(bytes);
    String tableKey = 'Hoja1';
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
  Map<String, Map<String, String>> engJson = {};
  // Map<String, String> dutchJson = {};

  for (var row in excel.tables[tableKey]!.rows) {
    List<Data?> data = row;
    // if (data.first != null) {
    //   String key = getKey(data.first!.value.toString());
    //   String value = data.first!.value.toString().trim();
    //   engJson[key] = value;
    // }
    //
    // if (data[9] != null) {
    //   String key = getKey(data.first!.value.toString());
    //
    //   String value = data[9]!.value.toString().trim();
    //   dutchJson[key] = value;
    // }

    for (int i = 0; i < data.length; i++) {
      Map<String, String> dutchJson = {};
      switch (i) {
        case 0:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['en'] == null) {
              engJson['en'] = dutchJson;
            }
            engJson['en']!.addAll(dutchJson);
          }
          break;
        case 1:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['ES'] == null) {
              engJson['ES'] = dutchJson;
            }
            engJson['ES']!.addAll(dutchJson);
          }
          break;
        case 2:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['CN'] == null) {
              engJson['CN'] = dutchJson;
            }
            engJson['CN']!.addAll(dutchJson);
          }
          break;

        case 3:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['GR'] == null) {
              engJson['GR'] = dutchJson;
            }
            engJson['GR']!.addAll(dutchJson);
          }
          break;

        case 4:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['FR'] == null) {
              engJson['FR'] = dutchJson;
            }
            engJson['FR']!.addAll(dutchJson);
          }
          break;

        case 5:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['PT'] == null) {
              engJson['PT'] = dutchJson;
            }
            engJson['PT']!.addAll(dutchJson);
          }
          break;

        case 6:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['IT'] == null) {
              engJson['IT'] = dutchJson;
            }
            engJson['IT']!.addAll(dutchJson);
          }
          break;
        case 7:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['RS'] == null) {
              engJson['RS'] = dutchJson;
            }
            engJson['RS']!.addAll(dutchJson);
          }
          break;

        case 8:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['JP'] == null) {
              engJson['JP'] = dutchJson;
            }
            engJson['JP']!.addAll(dutchJson);
          }
          break;

        case 9:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['NL'] == null) {
              engJson['NL'] = dutchJson;
            }
            engJson['NL']!.addAll(dutchJson);
          }
          break;
        case 10:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['DK'] == null) {
              engJson['DK'] = dutchJson;
            }
            engJson['DK']!.addAll(dutchJson);
          }
          break;

        case 11:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['FI'] == null) {
              engJson['FI'] = dutchJson;
            }
            engJson['FI']!.addAll(dutchJson);
          }
          break;
        case 12:
          if (data[i] != null) {
            dutchJson.addAll(getTranData(data[0]!, data[i]!));
            if (engJson['RO'] == null) {
              engJson['RO'] = dutchJson;
            }
            engJson['RO']!.addAll(dutchJson);
          }
          break;
      }
    }
  }

  // engJson.remove('english');
  // dutchJson.remove('english');

  // print(engJson.stringFi);
  engJson.forEach((key, value) {
    value.remove('🇬🇧English');
    saveFile(jsonMap: value, key: key);
  });
  //
  // saveFile(jsonMap: dutchJson, key: 'nl');
}

Map<String, String> getTranData(Data data0, Data data) {
  Map<String, String> lanJson = {};
  String key = getKey(data0.value.toString());
  String value = data.value.toString().trim();
  lanJson[key] = value;
  return lanJson;
}

void saveFile({required Map<String, String> jsonMap, required String key}) {
  print('----------------- $key -------------');
  File duJsonFile = File('lib/xl_to_json/$key.json');
  duJsonFile.writeAsString(jsonMap.stringFi);
  print(jsonMap.stringFi);
}

extension StringFi on Map {
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
      .replaceAll('”', '');
  try {
    key = camelCase(key);
  } catch (e) {
    print('error ------> $e $key');
  }
  if (key == 'continue') {
    key = 'continue_e';
  }

  return key;
}
