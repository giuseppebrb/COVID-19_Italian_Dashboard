import 'package:covid19italiandashboard/pages/MainPage.dart';
import 'package:covid19italiandashboard/pages/RegionsListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'localization/Translations.dart';

void main() => runApp(CovidItalianDashboardApp());

class CovidItalianDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'app_title'),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('it', ''),
        const Locale('en', ''),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> mainPages = <Widget>[
    MainPage(),
    RegionsListPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(Translations.of(context).text(widget.title)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, child:
          AlertDialog(
            title: Text(Translations.of(context).text('donations')),
            content: Wrap(
              children: <Widget>[
                Center(
                  child: Image.asset('assets/img/protezione_civile.png', height: 70),
                ),
                SizedBox(height: 16),
                Text(Translations.of(context).text('donations_message')),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Center(
                      child: OutlineButton(
                          onPressed: () { launch('http://www.protezionecivile.gov.it/attivita-rischi/rischio-sanitario/emergenze/coronavirus/come-donare'); },
                          child: Text(Translations.of(context).text('protezione_civile_website'))
                      ),
                    )
                )
              ],
            ),
          )
          );
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.pink,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(Translations.of(context).text('bottom_nav_home'))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: Text(Translations.of(context).text('bottom_nav_regions')),
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: mainPages.elementAt(_selectedIndex),
    );
  }
}
