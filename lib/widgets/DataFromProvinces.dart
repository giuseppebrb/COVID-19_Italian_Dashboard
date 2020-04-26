import 'package:covid19italiandashboard/localization/Translations.dart';
import 'package:covid19italiandashboard/models/ProvinceTrend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataFromProvinces extends StatelessWidget {
  final List<ProvinceTrend> provincesTrendList;

  DataFromProvinces({this.provincesTrendList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
                          Translations.of(context).text('data_from_provinces'),
                          style: Theme.of(context).textTheme.title
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(Translations.of(context).text('data_from_provinces_text')),
                    ),
                  ),
                  SizedBox(height: 16),
                  for(var provinceTrend in provincesTrendList)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        child: _buildProvinceData(provinceTrend, context),
                      ),
                    ),
                  SizedBox(height: 16)
                ]
              )
            )
          ]
        )
      )
    );
  }
  
  Widget _buildProvinceData(ProvinceTrend provinceTrend, BuildContext context) {
    if (provinceTrend.provinceName.contains('aggiornamento')) {
      return Container();
    }
    return Container(
      child: Row(
        children: <Widget>[
          Text(
              provinceTrend.provinceName + ': ',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
          Text(
              provinceTrend.totalCases.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[300]
              )
          )
        ],
      )
    );
  }

}