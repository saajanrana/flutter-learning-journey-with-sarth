import 'package:flutter/material.dart';
import 'package:internship_project/models/teammodel.dart';
import 'package:internship_project/widgets/appbarwidget.dart';

class TeamInfoScreen extends StatefulWidget {
  final String teamName;
  final String teamKey;

  const TeamInfoScreen({super.key, required this.teamName, required this.teamKey});

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {
  late Future<TeamModel> futureTeamModel;

  @override
  void initState() {
    super.initState();
    futureTeamModel = fetchTeamModel(widget.teamKey);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(backButton: true),
      body: Text(widget.teamName),
    );
  }
}
