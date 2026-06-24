import 'package:flutter/material.dart';
import 'package:internship_project/models/matchmodel.dart';
import 'package:internship_project/widgets/appbarwidget.dart';

class MatchInfoScreen extends StatefulWidget {
  final String matchName;
  final String matchKey;

  const MatchInfoScreen({super.key, required this.matchName, required this.matchKey});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  late Future<MatchModel> futureMatchModel;

  @override
  void initState() {
    super.initState();
    futureMatchModel = fetchMatchModel(widget.matchKey);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(backButton: true),
      body: Text(widget.matchName),
    );
  }
}
