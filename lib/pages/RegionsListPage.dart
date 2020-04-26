import 'package:covid19italiandashboard/localization/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegionPage.dart';

class RegionsListPage extends StatefulWidget {
  RegionsListPage({Key key}) : super(key: key);

  @override
  _RegionsListPageState createState() => _RegionsListPageState();
}

class _RegionsListPageState extends State<RegionsListPage> {
  final regions = [
    'Abruzzo', 'Basilicata', 'Calabria', 'Campania', 'Emilia-Romagna', 'Friuli Venezia Giulia',
    'Lazio', 'Liguria', 'Lombardia', 'Marche', 'Molise', 'Piemonte', 'Puglia',
    'Sardegna', 'Sicilia', 'Toscana', 'Umbria', 'Valle d\'Aosta', 'Veneto'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
        Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
                children: <Widget>[
                  Center(
                      child:
                      Text(Translations.of(context).text('regions_list'),
                          style: Theme.of(context).textTheme.title
                      )
                  ),
                  SizedBox(height: 16),
                  Text(Translations.of(context).text('regions_page_text')),
                  SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                          children: <Widget>[
                            ListView.separated(
                                itemBuilder: (_, index) => GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegionsPage(
                                          regionName: regions.elementAt(index)
                                        )
                                      )
                                  ),
                                  child: SizedBox(
                                      height: 38,
                                      child: InkWell(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                              Text(
                                                regions.elementAt(index),
                                                style: Theme.of(context).textTheme.title
                                              )
                                          )
                                      )
                                  ),
                                ),
                                separatorBuilder: (_, __) => Divider(),
                                itemCount: regions.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true
                            )
                          ]
                      )
                  )
                ]
            )
        )
    );
  }

}