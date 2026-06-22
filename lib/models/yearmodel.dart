import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/simpleeventmodel.dart';
import 'package:internship_project/models/teammodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class YearModel {
  final Future<List> events;
  final List eventKeys;
  final Future<List> teams;
  final List teamKeys;
  final int year;

  YearModel({
    required this.events,
    required this.eventKeys,
    required this.teams,
    required this.teamKeys,
    required this.year,
  });

  factory YearModel.fromJson(List eventJson, List teamJson, int year) {
    List<Future> events = [];
    List eventKeys = [];
    List<Future> teams = [];
    List teamKeys = [];
    for (var eventKey in eventJson) {
      events.add(fetchSimpleEventModel(eventKey));
      eventKeys.add(eventKey);
    }
    for (var teamKey in teamJson) {
      teams.add(fetchTeamModel(teamKey));
      teamKeys.add(teamKey);
    }
    return YearModel(
      events: Future.wait(events),
      eventKeys: eventKeys,
      teams: Future.wait(teams),
      teamKeys: teamKeys,
      year: year,
    );
  }

  @override
  String toString() => '$year';
}

Future<YearModel> fetchYearModel(int year) async {
  final eventsResponse = await http.get(
    Uri.parse('$baseURL/events/$year/keys'),
    headers: headers,
  );
  List teamsResponses = [];
  for (int page = 0; page < 24; page++) {
    teamsResponses.add(
      await http.get(
        Uri.parse('$baseURL/teams/$year/$page/keys'),
        headers: headers,
      ),
    );
  }

  if (eventsResponse.statusCode == 200 && teamsResponses[0].statusCode == 200) {
    List teamsResponse = [];
    for (var teamResponse in teamsResponses) {
      teamsResponse += jsonDecode(teamResponse.body) as List;
    }
    return YearModel.fromJson(
      jsonDecode(eventsResponse.body) as List,
      teamsResponse,
      year,
    );
  } else {
    throw Exception('Failed to load Year Data');
  }
}
