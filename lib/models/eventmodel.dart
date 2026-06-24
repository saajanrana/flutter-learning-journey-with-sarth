import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/matchmodel.dart';
import 'package:internship_project/models/simpleteammodel.dart';
import 'package:internship_project/models/teammodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class EventModel {
  final Future<List> teams;
  final List teamKeys;
  final Future<List> matches;
  final List matchKeys;
  final String name;
  final int year;
  final String key;

  EventModel({
    required this.teams,
    required this.teamKeys,
    required this.matches,
    required this.matchKeys,
    required this.name,
    required this.year,
    required this.key,
  });

  factory EventModel.fromJson(
    List teamJson,
    List matchJson,
    Map<String, dynamic> eventJson,
  ) {
    List<Future> teams = [];
    List teamKeys = [];
    List<Future> matches = [];
    List matchKeys = [];
    for (var teamKey in teamJson) {
      teams.add(fetchSimpleTeamModel(teamKey));
      teamKeys.add(teamKey);
    }
    for (var matchKey in matchJson) {
      matches.add(fetchMatchModel(matchKey));
      matchKeys.add(matchKey);
    }
    return switch (eventJson) {
      {'key': String key, 'name': String name, 'year': int year} => EventModel(
        teams: Future.wait(teams),
        teamKeys: teamKeys,
        matches: Future.wait(matches),
        matchKeys: matchKeys,
        name: name,
        year: year,
        key: key,
      ),
      _ => throw FormatException('Failed to load Event Data.'),
    };
  }

  @override
  String toString() => '$year $name';
}

Future<EventModel> fetchEventModel(String eventKey) async {
  final teamResponse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/teams/keys'),
    headers: headers,
  );
  final matchResponse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/matches/keys'),
    headers: headers,
  );
  final eventResonse = await http.get(
    Uri.parse('$baseURL/event/$eventKey/simple'),
    headers: headers,
  );

  if (matchResponse.statusCode == 200 &&
      teamResponse.statusCode == 200 &&
      eventResonse.statusCode == 200) {
    return EventModel.fromJson(
      jsonDecode(teamResponse.body) as List,
      jsonDecode(matchResponse.body) as List,
      jsonDecode(eventResonse.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load Event Data');
  }
}
