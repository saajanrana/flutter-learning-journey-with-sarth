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

class SimpleTeamModel {
  final int teamNumber;
  final String nickname;
  final String key;
  int epa;

  SimpleTeamModel({
    required this.teamNumber,
    required this.nickname,
    required this.key,
    required this.epa,
  });

  factory SimpleTeamModel.fromJson(Map<String, dynamic> teamJson) {
    return switch (teamJson) {
      {
        'team_number': int teamNumber,
        'nickname': String nickname,
        'key': String key,
      } =>
        SimpleTeamModel(
          teamNumber: teamNumber,
          nickname: nickname,
          key: key,
          epa: 50,
        ),
      _ => throw FormatException('Failed to load Team Data.'),
    };
  }

  @override
  String toString() => '$nickname ($teamNumber)';
}

Future<SimpleTeamModel> fetchSimpleTeamModel(String teamKey) async {
  final teamResponse = await http.get(
    Uri.parse('$baseURL/team/$teamKey'),
    headers: headers,
  );

  if (teamResponse.statusCode == 200) {
    return SimpleTeamModel.fromJson(
      jsonDecode(teamResponse.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load Team Data');
  }
}
