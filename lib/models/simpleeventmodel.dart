import 'dart:convert';

import 'package:http/http.dart' as http;

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class SimpleEventModel {
  final String name;
  final int year;
  final String key;

  SimpleEventModel({required this.name, required this.year, required this.key});

  factory SimpleEventModel.fromJson(Map<String, dynamic> eventJson) {
    return switch (eventJson) {
      {'key': String key, 'name': String name, 'year': int year} =>
        SimpleEventModel(name: name, year: year, key: key),
      _ => throw FormatException('Failed to load Event Data.'),
    };
  }

  @override
  String toString() => '$year $name';
}

Future<SimpleEventModel> fetchSimpleEventModel(String eventKey) async {
  final eventResonse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/simple'),
    headers: headers,
  );

  if (eventResonse.statusCode == 200) {
    return SimpleEventModel.fromJson(
      jsonDecode(eventResonse.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load Event Data');
  }
}
