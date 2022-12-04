import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

/// widgets/methods that are used mutliple times in other files, so I have
/// placed them here to organize the code

class ChartWidgets {
  List<String> seriesNames = [
    "Name", "Price", "Rating x 100", "Rating/Price x 100", "Capacity", "Date", "Date Created"
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
        charts.BasicNumericTickProviderSpec(desiredTickCount: 1)
      ),
      secondaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec:
          charts.BasicNumericTickProviderSpec(desiredTickCount: 1)
      ),

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
        minBarLengthPx: 100,
        maxBarWidthPx: 100,
        // rounded edge on the bars
        cornerStrategy: const charts.ConstCornerStrategy(10),
        strokeWidthPx: 40.0,
      ),

      /// to show a legend
      behaviors: [charts.SeriesLegend(desiredMaxColumns: series.length)],
      selectionModels: [
        // only prints to the console right now (prints value of the selected bar)
        // not useful at the moment
        SelectionModelConfig(
          changedListener: (SelectionModel model) {
            if(model.hasDatumSelection) {
              print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
            }
          }
        )
      ],
    );
  }

  pieChartWidget(List<Series<ChartData, String>> series, bool isVertical,
      int rotationValue) {
    return charts.PieChart(
      series,
    );
  }

  /// to add the data for either upvotes or downvotes (voteType specifies which)
  List<ChartData> addChartData(var dataItems, MaterialColor selectedColour, String voteType) {
    final List<ChartData> chartData =[];
    for (int i=0; i < dataItems!.length; i++)
    {
      // upvotes/downvotes for this post
      chartData.add(
          ChartData(
              name: dataItems?.elementAt(i)[seriesNames[0]],
              value: (dataItems?.elementAt(i)[voteType]).toDouble(),
              barColor: charts.ColorUtil.fromDartColor(selectedColour)
          )
      );
    }
    return chartData;
  }

  /// for horizontal and vertical bar chart
  List<charts.Series<ChartData, String>> fillChartSeries (
      List<ChartData> priceData,
      List<ChartData> ratingData,
      List<ChartData> ratingValuePerPriceData,
      List<ChartData> capacityData) {
    return [
      // price series
      charts.Series(
        id: seriesNames[1],
        data: priceData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) =>series.value,
        colorFn: (ChartData series, _) =>series.barColor,),
      // rating series
      charts.Series(
        id: seriesNames[2],
        data: ratingData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) =>series.value,
        colorFn: (ChartData series, _) =>series.barColor,),
      // ratingValuePerPrice series
      charts.Series(
        id: seriesNames[3],
        data: ratingValuePerPriceData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) =>series.value,
        colorFn: (ChartData series, _) =>series.barColor,),
      // capacity series
      charts.Series(
        id: seriesNames[4],
        data: capacityData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) =>series.value,
        colorFn: (ChartData series, _) =>series.barColor,)
    ];
  }

  /// for pie chart
  List<charts.Series<ChartData, String>> fillPieChartSeries (
      List<ChartData> voteData, String voteType) {
    return [
      //
      charts.Series(
        id: voteType,
        data: voteData,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) =>series.value,
        colorFn: (ChartData series, _) =>series.barColor,
        //labelAccessorFn: (ChartData series, _) => series.title
      ),
    ];
  }


}

class ChartData {
  late final String name;
  late final double value;
  late final charts.Color barColor;

  ChartData({
    required this.name, required this.value, required this.barColor
  });
}
