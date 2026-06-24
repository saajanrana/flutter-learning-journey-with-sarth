import 'package:flutter/material.dart';
import 'package:internship_project/widgets/categorycardwidget.dart';
import 'package:internship_project/widgets/horizontallistwidget.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 300),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                children: [
                  CategoryCardWidget(widgetNum: 1),
                  CategoryCardWidget(widgetNum: 2),
                  CategoryCardWidget(widgetNum: 3),
                  CategoryCardWidget(widgetNum: 4),
                  CategoryCardWidget(widgetNum: 5),
                  CategoryCardWidget(widgetNum: 6),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    HorizontalListWidget(widgetNum: 1),
                    HorizontalListWidget(widgetNum: 2),
                    HorizontalListWidget(widgetNum: 3),
                    HorizontalListWidget(widgetNum: 4),
                    HorizontalListWidget(widgetNum: 5),
                    HorizontalListWidget(widgetNum: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
