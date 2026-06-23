import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/simpleeventmodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class YearEventsModel {
  final Future<List> events;
  final List eventKeys;
  final int year;

  YearEventsModel({
    required this.events,
    required this.eventKeys,
    required this.year,
  });

  factory YearEventsModel.fromJson(List eventJson, int year) {
    List<Future> events = [];
    List eventKeys = [];
    for (var eventKey in eventJson) {
      events.add(fetchSimpleEventModel(eventKey));
      eventKeys.add(eventKey);
    }
    return YearEventsModel(
      events: Future.wait(events),
      eventKeys: eventKeys,
      year: year,
    );
  }

  @override
  String toString() => '$year';
}

Future<YearEventsModel> fetchYearEventsModel(int year) async {
  final eventsResponse = await http.get(
    Uri.parse('$baseURL/events/$year/keys'),
    headers: headers,
  );

  if (eventsResponse.statusCode == 200) {
    return YearEventsModel.fromJson(
      jsonDecode(eventsResponse.body) as List,
      year,
    );
  } else {
    throw Exception('Failed to load Year Events Data');
  }
}
