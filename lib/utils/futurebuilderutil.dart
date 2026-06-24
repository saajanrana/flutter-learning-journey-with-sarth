import 'package:flutter/material.dart';
import 'package:internship_project/widgets/listtilewidgets/eventlisttilewidget.dart';
import 'package:internship_project/widgets/listtilewidgets/matchlisttilewidget.dart';
import 'package:internship_project/widgets/listtilewidgets/teamlisttilewidget.dart';

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
  final String type;

  const ListFutureBuilderUtil({
    super.key,
    required this.future,
    required this.filter,
    required this.filterValue,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List filteredList = filter
              ? (snapshot.data! as List)
                    .where(
                      (item) => item.toString().toLowerCase().contains(
                        filterValue.toLowerCase(),
                      ),
                    )
                    .toList()
              : (snapshot.data! as List);
          return ListView.builder(
            itemCount: filteredList.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return switch (type) {
                'events' => EventListTileWidget(
                  title: filteredList[index].toString(),
                  eventKey: filteredList[index].key,
                ),
                'teams' => TeamListTileWidget(
                  title: filteredList[index].toString(),
                  teamKey: filteredList[index].key,
                ),
                'matches' => MatchListTileWidget(
                  title: filteredList[index].toString(),
                  matchKey: filteredList[index].key,
                ),
                String() => throw UnimplementedError(),
              };
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
