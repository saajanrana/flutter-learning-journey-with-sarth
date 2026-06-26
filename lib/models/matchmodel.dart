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

class MatchModel {
  final Future<List> redAlliance;
  final List redAllianceKeys;
  final int redAllianceScore;
  final Future<List> blueAlliance;
  final List blueAllianceKeys;
  final int blueAllianceScore;
  final String eventKey;
  final String compLvl;
  final int matchNum;
  final int setNum;
  final String key;

  MatchModel({
    required this.redAlliance,
    required this.redAllianceKeys,
    required this.redAllianceScore,
    required this.blueAlliance,
    required this.blueAllianceKeys,
    required this.blueAllianceScore,
    required this.eventKey,
    required this.compLvl,
    required this.matchNum,
    required this.setNum,
    required this.key,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    List<Future> redAlliance = [];
    List redAllianceKeys = json['alliances']['red']['team_keys'];
    for (var key in redAllianceKeys) {
      redAlliance.add(fetchSimpleTeamModel(key));
    }
    List<Future> blueAlliance = [];
    List blueAllianceKeys = json['alliances']['blue']['team_keys'];
    for (var key in blueAllianceKeys) {
      blueAlliance.add(fetchSimpleTeamModel(key));
    }
    
    return switch (json) {
      {
        'event_key': String eventKey,
        'comp_level': String compLvl,
        'match_number': int matchNum,
        'set_number': int setNum,
        'key': String key,
      } =>
        MatchModel(
          redAlliance: Future.wait(redAlliance),
          redAllianceKeys: redAllianceKeys,
          redAllianceScore: json['alliances']['red']['score'],
          blueAlliance: Future.wait(blueAlliance),
          blueAllianceKeys: blueAllianceKeys,
          blueAllianceScore: json['alliances']['blue']['score'],
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
    Uri.parse('$baseURL/match/$matchKey/simple'),
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