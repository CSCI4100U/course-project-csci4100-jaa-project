import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/db_models/event_model.dart';

class EventTable extends StatefulWidget {
  static String routeName = "/events";
  String? title;

  EventTable({Key? key, this.title= "Table"}) : super(key: key);

  @override
  State<EventTable> createState() => _EventTableState();
}

class _EventTableState extends State<EventTable> {
  final List<String> columnNames = ['id', 'Name', 'Price', 'Rating', 'Date', 'Date Created'];
  final EventModel _eventModel = EventModel();
  int currentId= 0;
  late List<Map> dataItems = List.empty(growable: true);

  @override
  void initState() {
    if (dataItems.isNotEmpty) {
      currentId = dataItems.length;
    }
    getAllEventsFromDb();
  }

  int currentSortCol = 0;
  bool isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body:
      /// so the user can scroll through the datatable items horizontally
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        /// so the user can scroll through the datatable items vertically
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 10,
            sortAscending: isAscending,
            sortColumnIndex: currentSortCol,
            columns: [
              // NAME COLUMN
              sortedColumnWidget(columnNames[1], columnNames[1]),
              // PRICE COLUMN
              sortedColumnWidget(columnNames[2], columnNames[2]),
              // RATING COLUMN
              sortedColumnWidget(columnNames[3], columnNames[3]),
              // DATE COLUMN
              sortedColumnWidget(columnNames[4], columnNames[4]),
              // CREATED AT DATE COLUMN
              sortedColumnWidget(columnNames[5], columnNames[5]),
            ],
            rows: dataItems.map((item){
              return generateData(
                item[columnNames[1]],
                item[columnNames[2]],
                item[columnNames[3]],
                item[columnNames[4]],
                item[columnNames[5]],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  DataRow generateData(String? name, double? price, double? rating, DateTime date, DateTime createdDate){
    return DataRow(
        cells: [
          /// name
          DataCell(Text(name!)),
          /// price
          DataCell(Text(price.toString()),),
          /// rating
          DataCell(Text(rating.toString()),),
          /// date
          DataCell(Text(condeseDateTime(date))),
          /// date created
          DataCell(Text(condeseDateTime(createdDate))),
        ]
    );
  }

  DataColumn sortedColumnWidget(String? title, String? dataName) {
    return DataColumn(
        label: Text(title!),
        onSort: (columnIndex, _) {
          setState(() {
            currentSortCol = columnIndex;
            if (isAscending) {
              // update isAscending
              isAscending = false;

              // change the sort from descending to ascending,
              // order by dataname (Name, Price, Rating, Date or Date created)
              dataItems.sort((itemA, itemB) =>
                  itemB[dataName].compareTo(itemA[dataName]));
            }
            else {
              // update isAscending
              isAscending = true;

              // change the sort from ascending to descending,
              // order by upvotes (Name, Price, Rating, Date or Date created)
              dataItems.sort((itemA, itemB) =>
                  itemA[dataName].compareTo(itemB[dataName]));
            }
          });
        }
    );
  }

  void getAllEventsFromDb() async {
    var events = await _eventModel.getAllEvents();
    for (int i = 0; i < events.length; i++){
      Map newDataItem = {};
      newDataItem[columnNames[0]] = currentId;
      newDataItem[columnNames[1]] = events[i].name;
      newDataItem[columnNames[2]] = events[i].price;
      newDataItem[columnNames[3]] = events[i].rating;
      newDataItem[columnNames[4]] = events[i].date;
      newDataItem[columnNames[5]] = events[i].createdAt;

      setState(() {
        dataItems.add(newDataItem);
        currentId++;
      });
    }
  }

  /// change DateTime to a string in just YYYY-MM-DD format.  (Used for better
  /// viewing for the user, because the user does not need to see the minutes,
  /// seconds, etc)
  String condeseDateTime (DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }
}
