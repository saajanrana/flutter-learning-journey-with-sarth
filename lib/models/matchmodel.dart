import 'dart:convert';

import 'package:http/http.dart' as http;

String baseURL = 'https://www.thebluealliance.com/api/v3';
String apiKey =
    'X6G2LsxbFs9xNzLyOJXeLYaPx8kOsFtcJEBg2XY1r3ssszWYXHAFuMdoKIqaQPJF';

Map<String, String> headers = {
  'X-TBA-Auth-Key': apiKey,
  'Accept': 'application/json',
};

class MatchModel {
  final Object alliances;
  final String eventKey;
  final String compLvl;
  final int matchNum;
  final int setNum;
  final String key;

  MatchModel({
    required this.alliances,
    required this.eventKey,
    required this.compLvl,
    required this.matchNum,
    required this.setNum,
    required this.key,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'alliances': Object alliances,
        'event_key': String eventKey,
        'comp_level': String compLvl,
        'match_number': int matchNum,
        'set_number': int setNum,
        'key': String key,
      } =>
        MatchModel(
          alliances: alliances,
          eventKey: eventKey,
          compLvl: compLvl,
          matchNum: matchNum,
          setNum: setNum,
          key: key,
        ),
      _ => throw FormatException('Failed to load Match Data.'),
    };
  }

  @override
  String toString() {
    String beg = switch (compLvl) {
      'qm' => 'Qualification Match',
      'sf' => 'Semifinals Match',
      'f' => 'Finals Match',
      String() => "",
    };
    String end = setNum > matchNum ? '$setNum' : '$matchNum';
    return '$beg $end';
  }
}

Future<MatchModel> fetchMatchModel(String matchKey) async {
  final response = await http.get(
    Uri.parse('$baseURL/match/$matchKey'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    return MatchModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load Match Data');
  }
}
