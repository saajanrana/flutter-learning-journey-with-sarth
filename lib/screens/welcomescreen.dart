import 'package:flutter/material.dart';
import 'package:internship_project/screens/cardsscreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('Welcome to the app!', textScaler: TextScaler.linear(3)),
        Text(
          'This is a scheduling app that will help maintain a daily schedule.',
          textScaler: TextScaler.linear(1.5),
        ),
        // Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: ElevatedButton(
        //     onPressed: () => Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => CardsScreen()),
        //     ),
        //     child: Text('Click me to go to the app!'),
        //   ),
        // ),
      ],
    );
  }
}
