import 'package:flutter/material.dart';
import 'package:internship_project/widgets/widgettree.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool pressed = false;
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: dark ? Brightness.dark : Brightness.light,
          onPrimary: Colors.white,
        ),
      ),
      home: WidgetTree(),
    );
  }
}
