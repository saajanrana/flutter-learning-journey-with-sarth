import 'dart:convert';

import 'package:http/http.dart' as http;

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class TeamData {
  final String nickname;
  final int teamNumber;

  const TeamData({
    required this.teamNumber,
    required this.nickname,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'team_number': int teamNumber, 'nickname': String nickname} => TeamData(
        teamNumber: teamNumber,
        nickname: nickname,
      ),
      _ => throw FormatException('Failed to load Team Data.'),
    };
  }
}

Future<TeamData> fetchTeamData() async {
  final response = await http.get(
    Uri.parse('$baseURL/team/frc2974'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    return TeamData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Team Data');
  }
}
