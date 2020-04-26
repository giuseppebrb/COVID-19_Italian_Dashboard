import 'dart:convert';

import 'package:covid19italiandashboard/localization/Translations.dart';
import 'package:covid19italiandashboard/models/ProvinceTrend.dart';
import 'package:covid19italiandashboard/models/Region.dart';
import 'package:covid19italiandashboard/models/RegionTrend.dart';
import 'package:covid19italiandashboard/widgets/DataFromProvinces.dart';
import 'package:covid19italiandashboard/widgets/DataSummary.dart';
import 'package:covid19italiandashboard/widgets/TodaySummary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegionsPage extends StatelessWidget {

  final String regionName;
  Future<List<RegionTrend>> latestRegionsTrendFuture;
  Future<List<RegionTrend>> historyRegionsTrendFuture;
  Future<List<ProvinceTrend>> provincesTrendFuture;

  RegionsPage({this.regionName}) {
    latestRegionsTrendFuture = fetchLatestRegionsTrend();
    historyRegionsTrendFuture = fetchHistoryRegionsTrend();
    provincesTrendFuture = fetchLatestProvincesTrend();
  }

  Future<List<RegionTrend>> fetchLatestRegionsTrend() async {
    final latestRegionsTrend = await http.get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni-latest.json');
    if (latestRegionsTrend.statusCode == 200) {
      List<RegionTrend> regionsTrendList = new List<RegionTrend>();
      final jsonBody = json.decode(latestRegionsTrend.body);
      for (int i = 0; jsonBody.length > i; i++) {
        regionsTrendList.add(RegionTrend.fromJson(jsonBody[i]));
      }
      return regionsTrendList;
    } else {
      throw new Exception();
    }
  }

  Future<List<RegionTrend>> fetchHistoryRegionsTrend() async {
    final historyRegionsTrend = await http.get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json');
    if (historyRegionsTrend.statusCode == 200) {
      List<RegionTrend> regionsTrendList = new List<RegionTrend>();
      final jsonBody = json.decode(historyRegionsTrend.body);
      for (int i = 0; jsonBody.length > i; i++) {
        regionsTrendList.add(RegionTrend.fromJson(jsonBody[i]));
      }
      return regionsTrendList;
    } else {
      throw new Exception();
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
      throw new Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text('regional_trend')),
        ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Future.wait([
            latestRegionsTrendFuture,
            historyRegionsTrendFuture,
            provincesTrendFuture
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RegionTrend> regionsTrend = snapshot.data[0];
              List<RegionTrend> historyRegionsTrend = snapshot.data[1];
              List<ProvinceTrend> provincesTrend = snapshot.data[2];
              provincesTrend = provincesTrend.where((province) => province.regionName == regionName).toList();
              RegionTrend currentRegionTrend = regionsTrend.firstWhere((regionTrend) => regionTrend.regionName == regionName);
              return Container(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                  Translations.of(context).text('trend_in') + regionName,
                                  style: Theme.of(context).textTheme.title
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(Translations.of(context).text('last_updated') +
                                      ' ${DateFormat('dd/MM/yyyy HH:mm').format(currentRegionTrend.date)}',
                                    style: Theme.of(context).textTheme.subtitle,
                                  )
                              )
                            ],
                          ),
                        ),
                        DataSummary(trend: currentRegionTrend),
                        Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: TodaySummary(
                                trendList: historyRegionsTrend.where((region) => region.regionName.toLowerCase() == this.regionName.toLowerCase()).toList()
                            )
                        ),
                        Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: DataFromProvinces(provincesTrendList: provincesTrend)
                        ),
                        SizedBox(height: 16)
                      ]
                  )
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return SizedBox(
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      )
    );
  }
}