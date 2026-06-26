import 'package:flutter/material.dart';
import 'package:internship_project/screens/infoscreens/matchinfoscreen.dart';

class MatchListTileWidget extends StatelessWidget {
  final String title;
  final String matchKey;
  final List<String> redAlliance;
  final int redAllianceScore;
  final List<String> blueAlliance;
  final int blueAllianceScore;

  const MatchListTileWidget({
    super.key,
    required this.title,
    required this.matchKey,
    required this.redAlliance,
    required this.redAllianceScore,
    required this.blueAlliance,
    required this.blueAllianceScore,
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title),

                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      '| $redAllianceScore |',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: redAllianceScore > blueAllianceScore
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      '| $blueAllianceScore |',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: blueAllianceScore > redAllianceScore
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            );
          } else {
            return ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title),
                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      ' ${redAlliance[0].substring(3)} ${redAlliance[1].substring(3)} ${redAlliance[2].substring(3)}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      '| $redAllianceScore |',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: redAllianceScore > blueAllianceScore
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      '| $blueAllianceScore |',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: blueAllianceScore > redAllianceScore
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(8.0),
                    child: Text(
                      '${blueAlliance[0].substring(3)} ${blueAlliance[1].substring(3)} ${blueAlliance[2].substring(3)} ',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            );
          }
        },
      ),
    );
  }
}
