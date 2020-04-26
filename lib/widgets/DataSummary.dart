import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../localization/Translations.dart';

class DataSummary extends StatelessWidget {
  DataSummary({this.trend});
  final trend;
  @override
  Widget build(BuildContext context) {
    final numberFormatter = new NumberFormat("#,###", 'it');
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width % 3,
                    child: Card(
                      color: Colors.red[100],
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            numberFormatter.format(trend.totalPositives),
                            style: Theme.of(context).textTheme.title,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          AutoSizeText(Translations.of(context).text('positives'), maxLines: 1)
                        ]
                      )
                    )
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width % 3,
                    child: Card(
                      color: Colors.green[100],
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            numberFormatter.format(trend.healed),
                            style: Theme.of(context).textTheme.title,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          AutoSizeText(Translations.of(context).text('healed'), maxLines: 1)
                        ]
                      )
                    )
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width % 3,
                    child: Card(
                      color: Colors.grey[400],
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            numberFormatter.format(trend.deceased),
                            style: Theme.of(context).textTheme.title,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          AutoSizeText(Translations.of(context).text('deceased'), maxLines: 1)
                        ]
                      )
                    )
                  )
                )
              ]
            )
        ),
      ],
    );
  }

}