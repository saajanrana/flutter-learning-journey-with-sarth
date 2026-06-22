import 'package:flutter/material.dart';

class TextFutureBuilderUtil extends StatelessWidget {
  final Future<dynamic> future;

  const TextFutureBuilderUtil({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
