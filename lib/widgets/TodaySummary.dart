import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19italiandashboard/localization/Translations.dart';
import 'package:flutter/src/painting/text_style.dart' as style;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodaySummary extends StatelessWidget {
  var trend;
  int deltaNewDeaths = 0;
  final List trendList;

  TodaySummary({this.trendList}) {
    var currentTrend = trendList.elementAt(trendList.length-1);
    var previousDayTrend = trendList.elementAt(trendList.length-2);
    trend = currentTrend;
    deltaNewDeaths = currentTrend.deceased - previousDayTrend.deceased;
  }

  _getValueColor(int value) {
    return value > 0 ? Colors.red[300] : Colors.green[300];
  }

  @override
  Widget build(BuildContext context) {
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
                        Translations.of(context).text('today_summary'),
                        style: Theme.of(context).textTheme.title
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(Translations.of(context).text('today_summary_text')),
                  ),
                ),
                Container(
                    child: ListTile(
                      leading: Image.asset('assets/img/corona_1.png', height: 32),
                      title: Align(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: AutoSizeText(
                                  Translations.of(context).text('new_positives'),
                                  style: Theme.of(context).textTheme.title
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                trend.newPositives.toString(),
                                maxLines: 1,
                                style: style.TextStyle(
                                    fontSize: 20,
                                    color: _getValueColor(trend.newPositives),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment(-1.2, 0),
                      ),
                    )
                ),
                Container(
                    child: ListTile(
                      leading: Image.asset('assets/img/delta_new_positives.png', height: 32),
                      title: Align(
                        child:
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: AutoSizeText(
                                      Translations.of(context).text('delta_new_positives'),
                                      style: Theme.of(context).textTheme.title
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    trend.deltaTotalPositive.toString(),
                                    maxLines: 1,
                                    style: style.TextStyle(
                                        fontSize: 20,
                                        color: _getValueColor(trend.deltaTotalPositive),
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                        alignment: Alignment(-1.2, 0),
                      ),
                    )
                ),
                Container(
                    child: ListTile(
                      leading: Image.asset('assets/img/delta_new_deaths.png', height: 32),
                      title: Align(
                        child:
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: AutoSizeText(
                                  Translations.of(context).text('delta_new_deaths'),
                                  style: Theme.of(context).textTheme.title
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                deltaNewDeaths.toString(),
                                maxLines: 1,
                                style: style.TextStyle(
                                    fontSize: 20,
                                    color: _getValueColor(deltaNewDeaths),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment(-1.2, 0),
                      ),
                    )
                ),
                Container(
                  child: ListTile(
                    leading: Image.asset('assets/img/swabs_logo.png', height: 32),
                    title: Align(
                      child:
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: AutoSizeText(
                                    Translations.of(context).text('swabs_done'),
                                    style: Theme.of(context).textTheme.title
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                    trend.swabs.toString(),
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.title
                                ),
                              )
                            ],
                          ),
                      alignment: Alignment(-1.2, 0),
                    ),
                  )
                ),
                SizedBox(height: 16)
              ],
            ),
          )
        ],
      ),
    );
  }

}