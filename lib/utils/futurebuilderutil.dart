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

class ListFutureBuilderUtil extends StatelessWidget {
  final Future<dynamic> future;
  final bool filter;
  final String filterValue;

  const ListFutureBuilderUtil({
    super.key,
    required this.future,
    required this.filter,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List filteredList = (snapshot.data! as List)
              .where((item) => item.toString().toLowerCase().contains(filterValue))
              .toList();
          return ListView.builder(
            itemCount: filteredList.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredList[index].toString()),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
