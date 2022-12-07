import 'package:course_project/constants.dart';
import 'package:course_project/screens/charts/vertical_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:course_project/models/db_models/event_model.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'components/chart_widgets.dart';

/// Horizontal Bar Chart screen
class HorizontalChart extends StatefulWidget {
  static String routeName = "/horizontalChart";
  List<Map>? dataItems;
  bool isVertical;
  int rotationValue;
  Icon chartButtonIcon;

  HorizontalChart(
      {Key? key,
      this.dataItems,
      this.isVertical = false,
      this.rotationValue = 0,
      this.chartButtonIcon = const Icon(
        Icons.align_vertical_bottom_outlined,
      )})
      : super(key: key);

  @override
  State<HorizontalChart> createState() => _HorizontalChartState();
}

class _HorizontalChartState extends State<HorizontalChart> {
  final List<String> columnNames = [
    'id',
    'Name',
    'Price',
    'Rating',
    'Capacity',
    'Rating/Price',
    'Capacity/Price',
  ];

  final EventModel _eventModel = EventModel();
  late List<Map> dataItems = List.empty(growable: true);
  int currentId = 0;

  @override
  void initState() {
    super.initState();
    if (dataItems.isNotEmpty) {
      currentId = dataItems.length;
    }
    getAllEventsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> priceData = [];
    List<ChartData> ratingData = [];
    List<ChartData> capacityData = [];
    List<ChartData> ratingValuePerPrice = [];
    List<ChartData> capacityPerPriceData = [];

    /// adding chart data
    priceData =
        ChartWidgets().addChartData(dataItems, Colors.blue, columnNames[2]);
    ratingData =
        ChartWidgets().addChartData(dataItems, Colors.red, columnNames[3]);
    capacityData =
        ChartWidgets().addChartData(dataItems, Colors.orange, columnNames[4]);
    ratingValuePerPrice =
        ChartWidgets().addChartData(dataItems, Colors.green, columnNames[5]);
    capacityPerPriceData =
        ChartWidgets().addChartData(dataItems, Colors.purple, columnNames[6]);

    List<charts.Series<ChartData, String>> series =
        ChartWidgets().fillChartSeries(
      priceData,
      ratingData,
      capacityData,
      ratingValuePerPrice,
      capacityPerPriceData,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, "charts.horizontal_bar.title"),
          style: const TextStyle(color: kPrimaryColor),
        ),
        actions: [
          /// vertical bar chart button (brings user to the vertical bar chart
          /// screen to see that chart)
          IconButton(
            iconSize: 30,
            onPressed: () {
              // go to the vertical chart screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerticalChart(
                          dataItems: dataItems,
                        )),
              );
            },
            icon: widget.chartButtonIcon,
          ),
        ],
      ),

      /// for zooming in and out
      /// (since certain parts of the chart are too long or too small to see
      /// well without any zoom options)
      body: dataItems.isNotEmpty
          ? Zoom(
              backgroundColor: Colors.white54,

              /// horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                /// vertical scrolling
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      child: SizedBox(
                        width: 1200,
                        height: 1000,

                        /// the bar chart
                        child: ChartWidgets().barChartWidget(
                            series, widget.isVertical, widget.rotationValue),
                      ),
                    )),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }

  void getAllEventsFromDb() async {
    var events = await _eventModel.getAllEvents();
    for (int i = 0; i < events.length; i++) {
      Map newDataItem = {};
      newDataItem[columnNames[0]] = currentId;
      newDataItem[columnNames[1]] = events[i].name;
      newDataItem[columnNames[2]] = events[i].price;
      newDataItem[columnNames[3]] = (events[i].rating) * 100;
      newDataItem[columnNames[4]] = events[i].capacity;

      /// if statement to check if rating and price are 0.  And capacity.
      if (events[i].rating > 0 && events[i].price! > 0) {
        newDataItem[columnNames[5]] =
            ((events[i].rating) / (events[i].price!)) * 100;
      } else {
        newDataItem[columnNames[5]] = 0.0;
      }
      if (events[i].capacity! > 0 && events[i].price! > 0) {
        newDataItem[columnNames[6]] =
            (events[i].capacity!) / (events[i].price!);
      } else {
        newDataItem[columnNames[6]] = 0.0;
      }

      setState(() {
        dataItems.add(newDataItem);
        currentId++;
      });
    }
  }
}
