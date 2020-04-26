import 'package:charts_flutter/flutter.dart';
import 'package:covid19italiandashboard/models/NationalTrend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../localization/Translations.dart';
import '../models/ChartData.dart';

class NationalTrendChart extends StatelessWidget {
  final List<NationalTrend> nationalTrendList;
  List<Series<ChartData, String>> seriesList;

  NationalTrendChart({this.nationalTrendList});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> deceasedData = [];
    final List<ChartData> intensiveCareData = [];
    final List<ChartData> hospitalizedWithSymptomsData = [];
    final List<ChartData> homeIsolationData = [];
    final List<ChartData> healedData = [];

    for(int i = nationalTrendList.length-1; i >= nationalTrendList.length - 10; i--) {
      var currentTrend = nationalTrendList.elementAt(i);

      deceasedData.add(new ChartData(currentTrend.date, currentTrend.deceased));
      intensiveCareData.add(new ChartData(currentTrend.date, currentTrend.intensiveCare));
      hospitalizedWithSymptomsData.add(new ChartData(currentTrend.date, currentTrend.hospitalizedWithSymptoms));
      homeIsolationData.add(new ChartData(currentTrend.date, currentTrend.homeIsolation));
      healedData.add(new ChartData(currentTrend.date, currentTrend.healed));
    }

    DateFormat dateFormat = DateFormat("d");
    seriesList = [
      new Series<ChartData, String>(
          id: Translations.of(context).text('healed'),
          data: healedData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#8CD17D')
      ),
      new Series<ChartData, String>(
          id: Translations.of(context).text('home_isolation'),
          data: homeIsolationData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#F0BD27')
      ),
      new Series<ChartData, String>(
          id: Translations.of(context).text('hospitalized_with_symptoms'),
          data: hospitalizedWithSymptomsData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#F28E2B')
      ),
      new Series<ChartData, String>(
          id: Translations.of(context).text('intensive_care'),
          data: intensiveCareData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#CA5422')
      ),
      new Series<ChartData, String>(
          id: Translations.of(context).text('deceased'),
          data: deceasedData,
          domainFn: (ChartData data, _) => dateFormat.format(data.date),
          measureFn: (ChartData data, _) => data.value,
          seriesColor: Color.fromHex(code: '#5C6068')
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
                        Translations.of(context).text('national_trend_history'),
                        style: Theme.of(context).textTheme.title
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(Translations.of(context).text('data_from_last_ten_days')),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: BarChart(
                      seriesList,
                      animate: true,
                      barGroupingType: BarGroupingType.stacked,
                      behaviors: [
                        SeriesLegend(
                            position: BehaviorPosition.bottom,
                            cellPadding: EdgeInsets.all(0),
                            outsideJustification: OutsideJustification.start,
                            horizontalFirst: false
                        ),
                        ChartTitle(Translations.of(context).text('days'),
                            behaviorPosition: BehaviorPosition.bottom,
                            outerPadding: 0,
                            innerPadding: 2,
                            titleOutsideJustification: OutsideJustification.middleDrawArea
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}