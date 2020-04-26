import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/Translations.dart';

class Footer extends StatelessWidget {
  launchDeveloperSite() async {
    const url = 'https://giuseppebrb.github.io/';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlatButton(
            child: Text(Translations.of(context).text('about_title')),
            onPressed: () {
              showDialog(context: context, child:
              AlertDialog(
                title: Text(Translations.of(context).text('about_title')),
                content: Wrap(
                  children: <Widget>[
                    Text(Translations.of(context).text('about_message')),
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Center(
                          child: OutlineButton(
                              onPressed: () { launchDeveloperSite(); },
                              child: Text(Translations.of(context).text('developer_website'))
                          ),
                        )
                    )
                  ],
                ),
              )
              );
            }
        )
    );
  }

}