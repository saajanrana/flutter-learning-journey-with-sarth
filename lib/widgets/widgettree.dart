import 'package:flutter/material.dart';
import 'package:internship_project/screens/cardsscreen.dart';
import 'package:internship_project/screens/welcomescreen.dart';
import 'package:internship_project/services/valuelisteners.dart';
import 'package:internship_project/widgets/appbarwidget.dart';
import 'package:internship_project/widgets/navigationbarwidget.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  List destinations = [WelcomeScreen(), CardsScreen()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: pageNotifier,
          builder: (context, value, child) {
            return Align(alignment: Alignment.center, child: SizedBox(height: 1000, width: 1000, child: Center(child: destinations[value])));
          }
        ),
      ),
      bottomNavigationBar: NavigationBarWidget()
    );
  }
}
