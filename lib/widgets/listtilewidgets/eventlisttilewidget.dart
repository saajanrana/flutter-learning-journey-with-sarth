import 'package:flutter/material.dart';
import 'package:internship_project/screens/infoscreens/eventinfoscreen.dart';

class EventListTileWidget extends StatelessWidget {
  final String title;
  final String eventKey;

  const EventListTileWidget({
    super.key,
    required this.title,
    required this.eventKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EventInfoScreen(eventName: title, eventKey: eventKey),
        ),
      ),
      child: ListTile(
        title: Text(title),
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      ),
    );
  }
}
