import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:course_project/models/db_models/event_model.dart';
import '../../components/chart_widgets.dart';

/// Vertical Bar Chart screen
class VerticalChart extends StatefulWidget {
  static String routeName = "/verticalChart";
  List<Map>? dataItems;
  bool isVertical;
  int rotationValue;
  String appBarTitle;
  Icon chartButtonIcon;

  VerticalChart({Key? key, this.dataItems, this.isVertical = true,
    this.rotationValue = -90, this.appBarTitle = "Vertical Bar Chart",
    this.chartButtonIcon = const Icon(Icons.align_vertical_bottom)}) : super(key: key);

  @override
  State<VerticalChart> createState() => _VerticalChartState();
}

class _VerticalChartState extends State<VerticalChart> {
  final List<String> columnNames = ['id', 'Name', 'Price', 'Rating', 'Rating/Price', 'Capacity'];

  @override
  Widget build(BuildContext context) {
    List<ChartData> priceData = [];
    List<ChartData> ratingData = [];
    List<ChartData> ratingValuePerPrice = [];
    List<ChartData> capacityData = [];

    priceData = ChartWidgets().addChartData(
        widget.dataItems,
        Colors.blue,
        columnNames[2]
    );
    ratingData = ChartWidgets().addChartData(
        widget.dataItems,
        Colors.red,
        columnNames[3]
    );
    ratingValuePerPrice = ChartWidgets().addChartData(
        widget.dataItems,
        Colors.green,
        columnNames[4]
    );
    capacityData = ChartWidgets().addChartData(
        widget.dataItems,
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
      ),
      /// horizontal scrolling
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        /// vertical scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 150),
            child: SizedBox(
              height: widget.dataItems!.length * 80,
              width: widget.dataItems!.length * 50,
              /// the bar chart
              child: ChartWidgets().barChartWidget(series, widget.isVertical, widget.rotationValue),
            ),
          )
        ),
      ),
    );

  }

}