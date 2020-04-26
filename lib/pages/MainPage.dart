import 'dart:convert';

import 'package:covid19italiandashboard/localization/Translations.dart';
import 'package:covid19italiandashboard/models/NationalTrend.dart';
import 'package:covid19italiandashboard/models/ProvinceTrend.dart';
import 'package:covid19italiandashboard/widgets/DataSummary.dart';
import 'package:covid19italiandashboard/widgets/Footer.dart';
import 'package:covid19italiandashboard/widgets/IncreaseOfPositivesChart.dart';
import 'package:covid19italiandashboard/widgets/NationalTrendChart.dart';
import 'package:covid19italiandashboard/widgets/TodaySummary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<NationalTrend> latestNationalTrendFuture;
  Future<List<ProvinceTrend>> latestProvincesTrendFuture;
  Future<List<NationalTrend>> historyNationalTrendFuture;

  Future<NationalTrend> fetchLatestNationalTrend() async {
    final latestNationalTrend = await http.get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale-latest.json');
    if (latestNationalTrend.statusCode == 200) {
      final jsonBody = json.decode(latestNationalTrend.body);
      return NationalTrend.fromJson(jsonBody[0]);
    } else {
      throw new Exception(Translations.of(context).text('error_fetch_national_trend'));
    }
  }

  Future<List<ProvinceTrend>> fetchLatestProvincesTrend() async {
    final latestProvincesTrend = await http.get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-province-latest.json');
    if (latestProvincesTrend.statusCode == 200) {
      List<ProvinceTrend> provincesTrendList = new List<ProvinceTrend>();
      final jsonBody = json.decode(latestProvincesTrend.body);
      for (int i = 0; jsonBody.length > i; i++) {
        provincesTrendList.add(ProvinceTrend.fromJson(jsonBody[i]));
      }
      return provincesTrendList;
    } else {
      throw new Exception(Translations.of(context).text('error_fetch_provinces_trend'));
    }
  }

  Future<List<NationalTrend>> fetchHistoryNationalTrend() async {
    final historyNationalTrend = await http.get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json');
    if (historyNationalTrend.statusCode == 200) {
      List<NationalTrend> historyNationalTrendList = new List<NationalTrend>();
      final jsonBody = json.decode(historyNationalTrend.body);
      for (int i = 0; jsonBody.length > i; i++) {
        historyNationalTrendList.add(NationalTrend.fromJson(jsonBody[i]));
      }
      return historyNationalTrendList;
    } else {
      throw new Exception(Translations.of(context).text('error_fetch_history_trend'));
    }
  }

  @override
  void initState() {
    super.initState();
    latestNationalTrendFuture = fetchLatestNationalTrend();
    latestProvincesTrendFuture = fetchLatestProvincesTrend();
    historyNationalTrendFuture = fetchHistoryNationalTrend();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder(
            future: Future.wait([
              latestNationalTrendFuture,
              latestProvincesTrendFuture,
              historyNationalTrendFuture
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var latestNationalTrend = snapshot.data[0];
                var latestProvincesTrend = snapshot.data[1];
                var historyNationalTrend = snapshot.data[2];
                return Container(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Column(
                      children: <Widget>[
                        Center(
                            child: Text(Translations.of(context).text('main_title'),
                                style: Theme.of(context).textTheme.title
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(Translations.of(context).text('last_updated') +
                                ' ${DateFormat('dd/MM/yyyy HH:mm').format(latestNationalTrend.date)}',
                              style: Theme.of(context).textTheme.subtitle,
                            )
                        ),
                        DataSummary(trend: latestNationalTrend),
                        SizedBox(height: 8),
                        Card(
                            elevation: 4,
                            child: TodaySummary(trendList: historyNationalTrend)
                        ),
                        Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: NationalTrendChart(nationalTrendList: historyNationalTrend)
                        ),
                        SizedBox(height: 8),
                        Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: IncreaseOfPositivesChart(nationalTrendList: historyNationalTrend)
                        ),
                        SizedBox(height: 8),
                        Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                                leading: Image.asset('assets/img/protezione_civile.png'),
                                title: Text(Translations.of(context).text('disclaimer')),
                                subtitle: Text(Translations.of(context).text('disclaimer_message'))
                            )
                        ),
                        SizedBox(height: 8),
                        Footer()
                      ]
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        )
    );
  }

}