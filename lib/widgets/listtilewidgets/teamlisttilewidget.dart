import 'package:flutter/material.dart';
import 'package:internship_project/screens/infoscreens/teaminfoscreen.dart';

class TeamListTileWidget extends StatelessWidget {
  final String title;
  final String teamKey;

  const TeamListTileWidget({
    super.key,
    required this.title,
    required this.teamKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TeamInfoScreen(teamName: title, teamKey: teamKey),
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
