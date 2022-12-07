import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter_i18n/flutter_i18n.dart';

/// widgets/methods that are used multiple times in other files, so I have
/// placed them here to organize the code

class ChartWidgets {
  final List<String> seriesNames = [
    "Name",
    "Price",
    "Rating x 100",
    "Capacity",
    "Rating/Price x 100",
    "Capacity/Price",
    "Date",
    "Date Created",
  ];
  barChartWidget(List<Series<ChartData, String>> series, bool isVertical,
      int rotationValue) {
    return charts.BarChart(
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      series,
      vertical: isVertical,
      primaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(desiredTickCount: 1)),
      secondaryMeasureAxis: const charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(desiredTickCount: 1)),

      /// for the label orientation and positioning
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          // Rotation Here,
          labelRotation: rotationValue,
          labelOffsetFromTickPx: -5,
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ),

      defaultRenderer: charts.BarRendererConfig(
        minBarLengthPx: 20,
        maxBarWidthPx: 50,
        // rounded edge on the bars
        cornerStrategy: const charts.ConstCornerStrategy(10),
        strokeWidthPx: 20.0,
      ),

      /// to show a legend (with a black text colour)
      behaviors: [
        charts.SeriesLegend(
            desiredMaxColumns: series.length,
            entryTextStyle: const charts.TextStyleSpec(
              color: charts.Color(r: 41, g: 38, b: 37),
            ))
      ],
    );
  }

  /// to add the data for certain value (eventDataType specifies which)
  List<ChartData> addChartData(
      var dataItems, MaterialColor selectedColour, String eventDataType) {
    final List<ChartData> chartData = [];
    for (int i = 0; i < dataItems!.length; i++) {
      // price, rating, etc for this event
      chartData.add(ChartData(
          name: dataItems?.elementAt(i)[seriesNames[0]],
          value: (dataItems?.elementAt(i)[eventDataType]).toDouble(),
          barColor: charts.ColorUtil.fromDartColor(selectedColour)));
    }
    return chartData;
  }

  /// for horizontal and vertical bar chart
  List<charts.Series<ChartData, String>> fillChartSeries(
      List<ChartData> priceData,
      List<ChartData> ratingData,
      List<ChartData> ratingValuePerPriceData,
      List<ChartData> capacityData,
      List<ChartData> capacityPerPriceData) {
    return [
      // price series
      charts.Series(
        id: seriesNames[1],
        data: priceData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.value,
        colorFn: (ChartData series, _) => series.barColor,
      ),
      // rating series
      charts.Series(
        id: seriesNames[2],
        data: ratingData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.value,
        colorFn: (ChartData series, _) => series.barColor,
      ),
      // capacity series
      charts.Series(
        id: seriesNames[3],
        data: capacityData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.value,
        colorFn: (ChartData series, _) => series.barColor,
      ),
      // ratingValuePerPrice series
      charts.Series(
        id: seriesNames[4],
        data: ratingValuePerPriceData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.value,
        colorFn: (ChartData series, _) => series.barColor,
      ),
      // capacityPerPriceData series
      charts.Series(
        id: seriesNames[5],
        data: capacityPerPriceData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.value,
        colorFn: (ChartData series, _) => series.barColor,
      ),
    ];
  }
}

/// ChartData class to store for the chart data series
class ChartData {
  late final String name;
  late final double value;
  late final charts.Color barColor;

  ChartData({required this.name, required this.value, required this.barColor});
}
