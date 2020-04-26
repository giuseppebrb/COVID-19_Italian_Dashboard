import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../localization/Translations.dart';
import '../models/ChartData.dart';
import '../models/NationalTrend.dart';

class IncreaseOfPositivesChart extends StatelessWidget {
  final List<NationalTrend> nationalTrendList;
  List<Series<ChartData, String>> seriesList;

  IncreaseOfPositivesChart({this.nationalTrendList});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> increaseData = [];

    for(int i = nationalTrendList.length-1; i >= nationalTrendList.length - 10; i--) {
      var currentTrend = nationalTrendList.elementAt(i);
      var previousTrend = nationalTrendList.elementAt(i-1);
      var differenceWithPreviousDay = ((currentTrend.newPositives - previousTrend.newPositives)/previousTrend.newPositives)*100;

      increaseData.add(new ChartData(currentTrend.date, differenceWithPreviousDay.toInt()));
    }
    DateFormat dateFormat = DateFormat("d");
    seriesList = [
      new Series<ChartData, String>(
          id: Translations.of(context).text('percentage_increase_message'),
          data: increaseData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#CA5422'),
          labelAccessorFn: (ChartData data, _) => '${data.value.toString()}%'
      )
    ];
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Text(
                        Translations.of(context).text('increase_of_new_positives'),
                        style: Theme.of(context).textTheme.title
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(Translations.of(context).text('percentage_from_last_ten_days')),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: BarChart(
                      seriesList,
                      animate: true,
                      barRendererDecorator: new BarLabelDecorator<String>(),
                      domainAxis: new OrdinalAxisSpec(),
                      behaviors: [
                        ChartTitle(Translations.of(context).text('days'),
                            behaviorPosition: BehaviorPosition.bottom,
                            outerPadding: 0,
                            innerPadding: 2,
                            titleOutsideJustification: OutsideJustification.middleDrawArea
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(Translations.of(context).text('percentage_disclaimer')),
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}