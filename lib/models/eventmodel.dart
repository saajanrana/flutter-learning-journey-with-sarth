import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/matchmodel.dart';
import 'package:internship_project/models/teammodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class EventModel {
  final List teams;
  final List matches;
  final String key;

  EventModel({required this.teams, required this.matches, required this.key});

  factory EventModel.fromJson(List matchJson, List teamJson, String key) {
    List t = [];
    List m = [];
    for (var matchKey in matchJson) {
      m.add(fetchMatchModel(matchKey));
    }
    for (var teamKey in teamJson) {
      t.add(fetchTeamModel(teamKey));
    }
    return EventModel(teams: t, matches: m, key: key);
  }

  @override
  String toString() => key;
}

Future<EventModel> fetchEventModel(String eventKey) async {
  final matchResponse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/matches/keys'),
    headers: headers,
  );

  final teamResponse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/teams/keys'),
    headers: headers,
  );

  if (matchResponse.statusCode == 200 && teamResponse.statusCode == 200) {
    return EventModel.fromJson(
      jsonDecode(matchResponse.body) as List,
      jsonDecode(teamResponse.body) as List,
      eventKey,
    );
  } else {
    throw Exception('Failed to load Event Data');
  }
}
