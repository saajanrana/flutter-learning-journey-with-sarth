import 'package:flutter/material.dart';
import 'package:internship_project/screens/infoscreens/matchinfoscreen.dart';

class MatchListTileWidget extends StatelessWidget {
  final String title;
  final String matchKey;

  const MatchListTileWidget({
    super.key,
    required this.title,
    required this.matchKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MatchInfoScreen(matchName: title, matchKey: matchKey),
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
