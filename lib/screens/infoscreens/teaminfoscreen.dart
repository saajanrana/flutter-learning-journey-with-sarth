import 'package:flutter/material.dart';
import 'package:internship_project/models/teammodel.dart';
import 'package:internship_project/services/valuelisteners.dart';
import 'package:internship_project/utils/futurebuilderutil.dart';
import 'package:internship_project/widgets/appbarwidget.dart';

class TeamInfoScreen extends StatefulWidget {
  final String teamName;
  final String teamKey;

  const TeamInfoScreen({
    super.key,
    required this.teamName,
    required this.teamKey,
  });

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {
  late Future<TeamModel> futureTeamModel;
  StringBuffer eventKeyBuffer = StringBuffer();

  @override
  void initState() {
    super.initState();
    futureTeamModel = fetchTeamModel(widget.teamKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(backButton: true),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.teamName, textScaler: TextScaler.linear(2)),
          FutureBuilder<TeamModel>(
            future: futureTeamModel,
            builder: (BuildContext context, AsyncSnapshot<TeamModel> snapshot) {
              if (snapshot.hasData) {
                return ValueListenableBuilder(
                  valueListenable: keyNotifier,
                  builder: (context, value, child) {
                    return DropdownListFutureBuilderUtil(
                      future: snapshot.data!.events,
                      value: StringBuffer(keyNotifier.value),
                    );
                  }
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return CircularProgressIndicator();
            },
          ),
          Flexible(
            child: FutureBuilder<TeamModel>(
              future: futureTeamModel,
              builder: (BuildContext context, AsyncSnapshot<TeamModel> snapshot) {
                if (snapshot.hasData) {
                  return ValueListenableBuilder(
                    valueListenable: keyNotifier,
                    builder: (context, value, child) {
                      return ClickableListFutureBuilderUtil(
                        future: snapshot.data!.matches,
                        filter: true,
                        filterValue: '',
                        type: 'matches',
                        filterByKey: true,
                        filterKey: value
                      );
                    }
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
            
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
