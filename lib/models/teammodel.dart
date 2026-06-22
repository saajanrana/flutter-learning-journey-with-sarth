import 'dart:convert';

import 'package:http/http.dart' as http;

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
  final String key;
  int epa;

  TeamModel({
    required this.teamNumber,
    required this.nickname,
    required this.key,
    required this.epa,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'team_number': int teamNumber,
        'nickname': String nickname,
        'key': String key,
      } =>
        TeamModel(
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

Future<TeamModel> fetchTeamModel(String teamKey) async {
  final response = await http.get(
    Uri.parse('$baseURL/team/$teamKey'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    return TeamModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load Team Data');
  }
}
