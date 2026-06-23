import 'package:flutter/material.dart';
import 'package:internship_project/utils/futurebuilderutil.dart';

class SearchTabWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Future future;
  final String type;
  const SearchTabWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.future,
    required this.type
  });

  @override
  State<SearchTabWidget> createState() => _SearchTabWidgetState();
}

class _SearchTabWidgetState extends State<SearchTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.hintText,
            ),
            controller: widget.controller,
            onChanged: (value) => setState(() {}),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: widget.future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListFutureBuilderUtil(
                  future: switch (widget.type) {
                    'events' => snapshot.data!.events,
                    'teams' => snapshot.data!.teams,
                    String() => throw UnimplementedError()
                  },
                  filter: true,
                  filterValue: widget.controller.value.text,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
