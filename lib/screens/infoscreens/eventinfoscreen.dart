import 'package:flutter/material.dart';
import 'package:internship_project/models/eventmodel.dart';
import 'package:internship_project/widgets/appbarwidget.dart';
import 'package:internship_project/widgets/searchtabwidget.dart';

class EventInfoScreen extends StatefulWidget {
  final String eventName;
  final String eventKey;

  const EventInfoScreen({
    super.key,
    required this.eventName,
    required this.eventKey,
  });

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  late Future<EventModel> futureEventModel;
  TextEditingController matchesController = TextEditingController();
  TextEditingController teamsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureEventModel = fetchEventModel(widget.eventKey);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.contrast), text: 'Matches'),
              Tab(icon: Icon(Icons.group), text: 'Teams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchTabWidget(
              controller: matchesController,
              future: futureEventModel,
              type: 'matches',
              search: false,
            ),
            SearchTabWidget(
              controller: teamsController,
              future: futureEventModel,
              type: 'teams',
              search: false,
            ),
          ],
        ),
      ),
    );
  }
}
