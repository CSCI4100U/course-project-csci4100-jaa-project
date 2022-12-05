import 'package:course_project/screens/charts/vertical_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:course_project/models/db_models/event_model.dart';
import '../../components/chart_widgets.dart';

/// Horizontal Bar Chart screen
class HorizontalChart extends StatefulWidget {
  static String routeName = "/horizontalChart";
  List<Map>? dataItems;
  bool isVertical;
  int rotationValue;
  String appBarTitle;
  Icon chartButtonIcon;

  HorizontalChart({Key? key, this.dataItems, this.isVertical = false,
    this.rotationValue = 0, this.appBarTitle = "Horizontal Bar Chart",
    this.chartButtonIcon = const Icon(Icons.align_vertical_bottom)}) : super(key: key);

  @override
  State<HorizontalChart> createState() => _HorizontalChartState();
}

class _HorizontalChartState extends State<HorizontalChart> {
  final List<String> columnNames = ['id', 'Name', 'Price', 'Rating', 'Rating/Price', 'Capacity'];
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

  @override
  Widget build(BuildContext context) {
    List<ChartData> priceData = [];
    List<ChartData> ratingData = [];
    List<ChartData> ratingValuePerPrice = [];
    List<ChartData> capacityData = [];

    /// adding chart data
    priceData = ChartWidgets().addChartData(
        dataItems,
        Colors.blue,
        columnNames[2]
    );
    ratingData = ChartWidgets().addChartData(
        dataItems,
        Colors.red,
        columnNames[3]
    );
    ratingValuePerPrice = ChartWidgets().addChartData(
        dataItems,
        Colors.green,
        columnNames[4]
    );
    capacityData = ChartWidgets().addChartData(
        dataItems,
        Colors.orange,
        columnNames[5]
    );


    List<charts.Series<ChartData, String>> series = ChartWidgets().fillChartSeries(
        priceData,
        ratingData,
        ratingValuePerPrice,
        capacityData,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          /// vertical bar chart button (brings user to the vertical bar chart
          /// screen to see that chart)
          IconButton(
            onPressed: () {
              //go to the vertical chart screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerticalChart(
                      dataItems: dataItems,
                    )
                ),
              );
            },
            icon: widget.chartButtonIcon,
          ),
        ],
      ),
      /// horizontal scrolling
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        /// vertical scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: SizedBox(
                height: dataItems.length * 90,
                width: dataItems.length * 100,
                /// the bar chart
                child: ChartWidgets().barChartWidget(series, widget.isVertical, widget.rotationValue),
              ),
            )
          ),
      ),
    );

  }

  void getAllEventsFromDb() async {
    var events = await _eventModel.getAllEvents();
    for (int i = 0; i < events.length; i++){
      Map newDataItem = {};
      newDataItem[columnNames[0]] = currentId;
      newDataItem[columnNames[1]] = events[i].name;
      newDataItem[columnNames[2]] = events[i].price;
      newDataItem[columnNames[3]] = (events[i].rating) * 100;
      newDataItem[columnNames[4]] = ((events[i].rating) / (events[i].price!)) * 100;
      newDataItem[columnNames[5]] = events[i].capacity;

      setState(() {
        dataItems.add(newDataItem);
        currentId++;
      });
    }
  }

}