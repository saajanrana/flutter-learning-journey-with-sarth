import 'package:flutter/material.dart';
import 'package:internship_project/models/yeareventsmodel.dart';
import 'package:internship_project/models/yearteamsmodel.dart';
import 'package:internship_project/widgets/searchtabwidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<YearEventsModel> futureYearEventsModel;
  late Future<YearTeamsModel> futureYearTeamsModel;
  TextEditingController eventsController = TextEditingController();
  TextEditingController teamsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureYearEventsModel = fetchYearEventsModel(2026);
    futureYearTeamsModel = fetchYearTeamsModel(2026);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.location_on), text: 'Events'),
              Tab(icon: Icon(Icons.group), text: 'Teams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchTabWidget(
              controller: eventsController,
              hintText: 'Search for Events',
              future: futureYearEventsModel,
              type: 'events',
              search: true,
            ),
            SearchTabWidget(
              controller: teamsController,
              hintText: 'Search for Teams',
              future: futureYearTeamsModel,
              type: 'teams',
              search: true,
            ),
          ],
        ),
      ),
    );
  }
}
