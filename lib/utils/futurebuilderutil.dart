import 'package:flutter/material.dart';
import 'package:internship_project/services/valuelisteners.dart';
import 'package:internship_project/widgets/loadingwidget.dart';
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

        return LoadingWidget();
      },
    );
  }
}

class ClickableListFutureBuilderUtil extends StatelessWidget {
  final Future<dynamic> future;
  final bool filter;
  final String filterValue;
  final String type;
  final bool filterByKey;
  final String filterKey;

  const ClickableListFutureBuilderUtil({
    super.key,
    required this.future,
    required this.filter,
    required this.filterValue,
    required this.type,
    required this.filterByKey,
    required this.filterKey,
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
                      (item) => filterByKey
                          ? item.eventKey == filterKey
                          : item.toString().toLowerCase().contains(
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
                  redAlliance: List<String>.from(filteredList[index].redAllianceKeys),
                  redAllianceScore: filteredList[index].redAllianceScore,
                  blueAlliance: List<String>.from(filteredList[index].blueAllianceKeys),
                  blueAllianceScore: filteredList[index].blueAllianceScore,
                ),
                String() => throw UnimplementedError(),
              };
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return LoadingWidget();
      },
    );
  }
}

class DropdownListFutureBuilderUtil extends StatefulWidget {
  final Future<dynamic> future;
  final StringBuffer? value;

  const DropdownListFutureBuilderUtil({
    super.key,
    required this.future,
    required this.value,
  });

  @override
  State<DropdownListFutureBuilderUtil> createState() =>
      _DropdownListFutureBuilderUtilState();
}

class _DropdownListFutureBuilderUtilState
    extends State<DropdownListFutureBuilderUtil> {
  bool setInitial = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DropdownMenuItem> dropdownOptions = [];
          for (var item in snapshot.data!) {
            dropdownOptions.add(
              DropdownMenuItem(value: item.key, child: Text(item.toString())),
            );
          }
          if (setInitial) {
            widget.value!.clear();
            widget.value!.write(snapshot.data![0].key);
            setInitial = false;
          }
          return ValueListenableBuilder(
            valueListenable: keyNotifier,
            builder: (context, value, child) {
              return DropdownButton(
                value: widget.value!.isEmpty ? null : widget.value.toString(),
                items: dropdownOptions,
                hint: Text('Select event'),
                onChanged: (v) => setState(() {
                  keyNotifier.value = v;
                  widget.value!.clear();
                  widget.value!.write(v);
                }),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return LoadingWidget();
      },
    );
  }
}
