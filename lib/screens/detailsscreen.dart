import 'package:flutter/material.dart';
import 'package:internship_project/widgets/appbarwidget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.widgetNum});

  final int widgetNum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(backButton: true),
      body: Text("Details page for grid widget $widgetNum"),
    );
  }
}