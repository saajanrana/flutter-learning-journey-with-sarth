import 'package:flutter/material.dart';
import 'package:internship_project/models/matchmodel.dart';
import 'package:internship_project/utils/futurebuilderutil.dart';
import 'package:internship_project/widgets/loadingwidget.dart';
import 'package:internship_project/widgets/appbarwidget.dart';

class MatchInfoScreen extends StatefulWidget {
  final String matchName;
  final String matchKey;

  const MatchInfoScreen({
    super.key,
    required this.matchName,
    required this.matchKey,
  });

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
      body: FutureBuilder<MatchModel>(
        future: futureMatchModel,
        builder: (BuildContext context, AsyncSnapshot<MatchModel> snapshot) {
          if (snapshot.hasData) {
            MatchModel matchData = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  Text(
                    '${matchData.toString()} (${matchData.eventKey})',
                    textScaler: TextScaler.linear(3),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Red Alliance - ${matchData.redAllianceScore}',
                                    textScaler: TextScaler.linear(2),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight:
                                          matchData.redAllianceScore >
                                              matchData.blueAllianceScore
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ClickableListFutureBuilderUtil(
                                      future: matchData.redAlliance,
                                      filter: false,
                                      filterValue: '',
                                      type: 'teams',
                                      filterByKey: false,
                                      filterKey: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${matchData.blueAllianceScore} - Blue Alliance',
                                    textScaler: TextScaler.linear(2),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight:
                                          matchData.blueAllianceScore >
                                              matchData.redAllianceScore
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ClickableListFutureBuilderUtil(
                                      future: matchData.blueAlliance,
                                      filter: false,
                                      filterValue: '',
                                      type: 'teams',
                                      filterByKey: false,
                                      filterKey: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Red Alliance - ${matchData.redAllianceScore}',
                                    textScaler: TextScaler.linear(2),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight:
                                          matchData.redAllianceScore >
                                              matchData.blueAllianceScore
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ClickableListFutureBuilderUtil(
                                      future: matchData.redAlliance,
                                      filter: false,
                                      filterValue: '',
                                      type: 'teams',
                                      filterByKey: false,
                                      filterKey: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${matchData.blueAllianceScore} - Blue Alliance',
                                    textScaler: TextScaler.linear(2),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight:
                                          matchData.blueAllianceScore >
                                              matchData.redAllianceScore
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ClickableListFutureBuilderUtil(
                                      future: matchData.blueAlliance,
                                      filter: false,
                                      filterValue: '',
                                      type: 'teams',
                                      filterByKey: false,
                                      filterKey: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return LoadingWidget();
        },
      ),
    );
  }
}
