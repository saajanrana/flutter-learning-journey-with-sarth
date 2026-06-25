import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/matchmodel.dart';
import 'package:internship_project/models/simpleeventmodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class TeamModel {
  final int teamNumber;
  final String nickname;
  final Future<List> events;
  final List eventKeys;
  final Future<List> matches;
  final List matchKeys;
  final String key;
  int epa;

  TeamModel({
    required this.teamNumber,
    required this.nickname,
    required this.events,
    required this.eventKeys,
    required this.matches,
    required this.matchKeys,
    required this.key,
    required this.epa,
  });

  factory TeamModel.fromJson(
    Map<String, dynamic> teamJson,
    List eventJson,
    List matchJson,
  ) {
    List<Future> events = [];
    List eventKeys = [];
    for (var eventKey in eventJson) {
      events.add(fetchSimpleEventModel(eventKey));
      eventKeys.add(eventKey);
    }
    List<Future> matches = [];
    List matchKeys = [];
    for (var matchKey in matchJson) {
      matches.add(fetchMatchModel(matchKey));
      matchKeys.add(matchKey);
    }

    return switch (teamJson) {
      {
        'team_number': int teamNumber,
        'nickname': String nickname,
        'key': String key,
      } =>
        TeamModel(
          teamNumber: teamNumber,
          nickname: nickname,
          events: Future.wait(events),
          eventKeys: eventKeys,
          matches: Future.wait(matches),
          matchKeys: matchKeys,
          key: key,
          epa: 50,
        ),
      _ => throw FormatException('Failed to load Team Data.'),
    };
  }

  @override
  String toString() => '$nickname ($teamNumber)';
}

Future<TeamModel> fetchTeamModel(String teamKey) async {
  final teamResponse = await http.get(
    Uri.parse('$baseURL/team/$teamKey'),
    headers: headers,
  );
  final eventsResponse = await http.get(
    Uri.parse('$baseURL/team/$teamKey/events/2026/keys'),
    headers: headers,
  );
  final matchesResponse = await http.get(
    Uri.parse('$baseURL/team/$teamKey/matches/2026/keys'),
    headers: headers,
  );

  if (teamResponse.statusCode == 200 &&
      eventsResponse.statusCode == 200 &&
      matchesResponse.statusCode == 200) {
    return TeamModel.fromJson(
      jsonDecode(teamResponse.body) as Map<String, dynamic>,
      jsonDecode(eventsResponse.body) as List,
      jsonDecode(matchesResponse.body) as List,
    );
  } else {
    throw Exception('Failed to load Team Data');
  }
}
