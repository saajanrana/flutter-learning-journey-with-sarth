import 'package:flutter/material.dart';
import 'package:internship_project/screens/detailsScreen.dart';

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget({super.key, required this.widgetNum});

  final int widgetNum;

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  bool favorited = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(widgetNum: widget.widgetNum),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 200,
              color: Colors.red,
              child: Center(child: Text('Grid item ${widget.widgetNum}')),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 35,
          child: Tooltip(
            message: favorited ? 'Unfavorite' : "Favorite",
            child: IconButton(
              onPressed: () => setState(() {
                favorited = !favorited;
              }),
              icon: Icon(favorited ? Icons.star : Icons.star_border),
            ),
          ),
        ),
      ],
    );
  }
}
