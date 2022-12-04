import 'package:course_project/screens/event/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import '../../../models/db_models/data_visualization_model.dart';
import '../../../models/entities/data_visualization.dart';
import '../../table/event_table.dart';

class DataVisualizationsDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //add data to db
    DataVisualizationModel _model = new DataVisualizationModel();
    List<List> info = [
      [0, "Table", "Table displaying the events data", const Icon(Icons.table_chart_rounded)],
      [1, "Charts", "Charts dispplaying the events data", const Icon(Icons.insert_chart)],
      [2, "Calendar", "Calendar displaying the events data", const Icon(Icons.calendar_month)]
    ];

    for (int i =0; i < 3; i++) {
      DataVisualization newDataVisualization = DataVisualization(
          id: info[i][0],
          name: info[i][1],
          description: info[i][2],
          icon: info[i][3],
      );
      _model.insertDataVisualization(newDataVisualization);
    }

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: StreamBuilder(
        stream: Stream.fromFuture(DataVisualizationModel().getAllDataVisualizations()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DataVisualization> dataVisualizations = snapshot.data ?? [];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                dataVisualizations.length,
                    (index) => DataVisualizationsCard(
                  icon: dataVisualizations[index].icon,
                  text: dataVisualizations[index].name,
                  press: () async => Navigator.pushNamed(
                      context, EventTable.routeName,
                      arguments: dataVisualizations[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataVisualizationsCard extends StatelessWidget {
  const DataVisualizationsCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final Widget? icon;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(105),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(85),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(190, 230, 249, 100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon!,
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
