import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_project/models/simpleteammodel.dart';

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class YearTeamsModel {
  final Future<List> teams;
  final List teamKeys;
  final int year;

  YearTeamsModel({
    required this.teams,
    required this.teamKeys,
    required this.year,
  });

  factory YearTeamsModel.fromJson(List teamJson, int year) {
    List<Future> teams = [];
    List teamKeys = [];
    for (var teamKey in teamJson) {
      teams.add(fetchSimpleTeamModel(teamKey));
      teamKeys.add(teamKey);
    }
    return YearTeamsModel(
      teams: Future.wait(teams),
      teamKeys: teamKeys,
      year: year,
    );
  }

  @override
  String toString() => '$year';
}

Future<YearTeamsModel> fetchYearTeamsModel(int year) async {
  List teamsResponses = [];
  for (int page = 0; page < 24; page++) {
    teamsResponses.add(
      await http.get(
        Uri.parse('$baseURL/teams/$year/$page/keys'),
        headers: headers,
      ),
    );
  }
  bool is200 = true;
  for (http.Response response in teamsResponses) {
    is200 = response.statusCode == 200;
  }

  if (is200) {
    List decodedList = [];
    for (http.Response response in teamsResponses) {
      decodedList += jsonDecode(response.body) as List;
    }
    return YearTeamsModel.fromJson(
      decodedList,
      year,
    );
  } else {
    throw Exception('Failed to load Year Teams Data');
  }
}
