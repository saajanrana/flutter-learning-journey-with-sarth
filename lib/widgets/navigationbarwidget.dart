import 'package:flutter/material.dart';
import 'package:internship_project/services/valuelisteners.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (context, value, child) {
        return NavigationBar(
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.auto_graph), label: 'Stuff'),
            ],
            onDestinationSelected: (value) => setState(() {
              pageNotifier.value = value;
            }),
            selectedIndex: pageNotifier.value,
          );
      }
    );
  }
}