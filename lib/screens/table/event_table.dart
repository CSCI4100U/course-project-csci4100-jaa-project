import 'package:flutter/material.dart';
import '../../models/db_models/event_model.dart';

/// Data Table Screen
class EventTable extends StatefulWidget {
  static String routeName = "/events-table";
  String? title;

  EventTable({Key? key, this.title = "Table"}) : super(key: key);

  @override
  State<EventTable> createState() => _EventTableState();
}

class _EventTableState extends State<EventTable> {
  final List<String> columnNames = [
    'id',
    'Name',
    'Price',
    'Rating',
    'Capacity',
    'Rating per Price',
    'Capacity per Price',
    'Date',
    'Date Created'
  ];
  final EventModel _eventModel = EventModel();
  final TextStyle tableTitleTextStyle = const TextStyle(
    color: Colors.indigo,
    fontSize: 25,
  );

  int currentId = 0;
  int currentSortCol = 0;
  bool isAscending = true; // for column sorting

  /// List of Maps to store the data for each event
  late List<Map> dataItems = List.empty(growable: true);

  @override
  void initState() {
    if (dataItems.isNotEmpty) {
      currentId = dataItems.length;
    }
    getAllEventsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!), // not shown at the moment
      ),
      body:

          /// so the user can scroll through the datatable items horizontally
          SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        /// so the user can scroll through the datatable items vertically
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// downward arrow (to show user they can scroll up and down)
              const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 10),
                child: Icon(
                  Icons.arrow_circle_down,
                  size: 50,
                  color: Colors.indigo,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// data table title
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          "Events Data Table    ",
                          style: tableTitleTextStyle,
                        ),

                        /// right arrow to show the user they can scroll right
                        /// and left)
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 50,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),

                  /// data table
                  DataTable(
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
                      // CAPACITY COLUMN
                      sortedColumnWidget(columnNames[4], columnNames[4]),
                      // RATING PER PRICE COLUMN
                      sortedColumnWidget(columnNames[5], columnNames[5]),
                      // CAPACITY PER PRICE COLUMN
                      sortedColumnWidget(columnNames[6], columnNames[6]),
                      // DATE COLUMN
                      sortedColumnWidget(columnNames[7], columnNames[7]),
                      // CREATED AT DATE COLUMN
                      sortedColumnWidget(columnNames[8], columnNames[8]),
                    ],
                    rows: dataItems.map((item) {
                      return generateData(
                        item[columnNames[1]],
                        item[columnNames[2]],
                        item[columnNames[3]],
                        item[columnNames[4]],
                        item[columnNames[5]],
                        item[columnNames[6]],
                        item[columnNames[7]],
                        item[columnNames[8]],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow generateData(
      String? name,
      double? price,
      double? rating,
      int? capacity,
      double? ratingPerPrice,
      double? capacityPerPrice,
      DateTime date,
      DateTime createdDate) {
    return DataRow(cells: [
      /// name
      DataCell(Text(name!)),

      /// price
      DataCell(
        Text(price.toString()),
      ),

      /// rating
      DataCell(
        Text(rating.toString()),
      ),

      /// capacity
      DataCell(Text(capacity.toString())),

      /// rating per price
      DataCell(
        Text(ratingPerPrice!.toStringAsFixed(2)),
      ),

      /// capacity per price
      DataCell(
        Text(capacityPerPrice!.toStringAsFixed(2)),
      ),

      /// date
      DataCell(Text(condenseDateTime(date))),

      /// date created
      DataCell(Text(condenseDateTime(createdDate))),
    ]);
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
              // order by dataname (Name, Price, Rating, Date, Capacity, etc)
              dataItems.sort(
                  (itemA, itemB) => itemB[dataName].compareTo(itemA[dataName]));
            } else {
              // update isAscending
              isAscending = true;

              // change the sort from ascending to descending,
              // order by dataname (Name, Price, Rating, Capacity, etc)
              dataItems.sort(
                  (itemA, itemB) => itemA[dataName].compareTo(itemB[dataName]));
            }
          });
        });
  }

  /// storing information about each event into the dataItems List of Maps
  void getAllEventsFromDb() async {
    var events = await _eventModel.getAllEvents();
    for (int i = 0; i < events.length; i++) {
      Map newDataItem = {};
      newDataItem[columnNames[0]] = currentId;
      newDataItem[columnNames[1]] = events[i].name;
      newDataItem[columnNames[2]] = events[i].price;
      newDataItem[columnNames[3]] = events[i].rating;
      newDataItem[columnNames[4]] = events[i].capacity;

      /// if statements for if there are ratings, prices, or capacities of 0
      if (events[i].rating != 0 && events[i].price != 0) {
        newDataItem[columnNames[5]] = events[i].rating / events[i].price!;
      } else {
        newDataItem[columnNames[5]] = 0.0;
      }
      if (events[i].capacity != 0 && events[i].price != 0) {
        newDataItem[columnNames[6]] =
            events[i].capacity!.toDouble() / events[i].price!;
      } else {
        newDataItem[columnNames[6]] = 0.0;
      }
      newDataItem[columnNames[7]] = events[i].date;
      newDataItem[columnNames[8]] = events[i].createdAt;

      setState(() {
        dataItems.add(newDataItem);
        currentId++;
      });
    }
  }

  /// change DateTime to a string in just YYYY-MM-DD format.  (Used for better
  /// viewing for the user, because the user does not need to see the minutes,
  /// seconds, etc)
  String condenseDateTime(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }
}
