import 'package:flutter/material.dart';

class HorizontalListWidget extends StatefulWidget {
  const HorizontalListWidget({super.key, required this.widgetNum});

  final int widgetNum;

  @override
  State<HorizontalListWidget> createState() => _HorizontalListWidgetState();
}

class _HorizontalListWidgetState extends State<HorizontalListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 350,
        color: Colors.blue,
        child: Center(child: Text('List item ${widget.widgetNum}')),
      ),
    );
  }
}
