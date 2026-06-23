import 'package:flutter/material.dart';
import 'package:internship_project/models/eventmodel.dart';
import 'package:internship_project/models/yeareventsmodel.dart';
import 'package:internship_project/models/yeareventsmodel.dart';
import 'package:internship_project/models/yearteamsmodel.dart';
import 'package:internship_project/screens/cardsscreen.dart';
import 'package:internship_project/screens/welcomescreen.dart';
import 'package:internship_project/models/teammodel.dart';
import 'package:internship_project/services/valuelisteners.dart';
import 'package:internship_project/utils/futurebuilderutil.dart';
import 'package:internship_project/widgets/appbarwidget.dart';
import 'package:internship_project/widgets/navigationbarwidget.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  late Future<EventModel> futureEventModel;
  late Future<YearEventsModel> futureYearEventsModel;
  late Future<YearTeamsModel> futureYearTeamsModel;

  @override
  void initState() {
    super.initState();
    futureEventModel = fetchEventModel('2024new');
    futureYearEventsModel = fetchYearEventsModel(2026);
    futureYearTeamsModel = fetchYearTeamsModel(2026);
  }

  List destinations = [WelcomeScreen(), CardsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      // body: SingleChildScrollView(
      //   child: ValueListenableBuilder(
      //     valueListenable: pageNotifier,
      //     builder: (context, value, child) {
      //       return Align(
      //         alignment: Alignment.center,
      //         child: SizedBox(
      //           height: 1000,
      //           width: 1000,
      //           child: Center(child: destinations[value]),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: FutureBuilder<YearTeamsModel>(
          future: futureYearTeamsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TextFutureBuilderUtil(future: snapshot.data!.teams);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
        
            return CircularProgressIndicator();
          },
        ),
      ),

      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
