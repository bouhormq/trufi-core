import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../trufi_localizations.dart';
import '../widgets/trufi_drawer.dart';

class AboutPage extends StatefulWidget {
  static const String route = "/about";

  @override
  State<StatefulWidget> createState() => new AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      drawer: TrufiDrawer(AboutPage.route),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localization = TrufiLocalizations.of(context).localization;
    return AppBar(title: Text(localization.menuAbout()));
  }

  Widget _buildBody(BuildContext context) {
    final localization = TrufiLocalizations.of(context).localization;
    final theme = Theme.of(context);
    final TextStyle linkStyle = theme.textTheme.body2.copyWith(
      color: theme.accentColor,
    );
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Text(
                  localization.title(),
                  style: theme.textTheme.title.copyWith(
                    color: theme.textTheme.body2.color,
                  ),
                ),
              ),
              Container(
                child: new FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<PackageInfo> snapshot,
                  ) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return Text("");
                    }
                    return Text(
                      localization.version(snapshot.data.version),
                      style: theme.textTheme.body2,
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  localization.tagline(),
                  style: theme.textTheme.subhead.copyWith(
                    color: theme.textTheme.body2.color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  localization.aboutContent(),
                  style: theme.textTheme.body2,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text(localization.aboutLicenses()),
                  onPressed: () {
                    return showLicensePage(
                      context: context,
                      applicationName: localization.title(),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: InkWell(
                  child: new Text(
                    localization.aboutOpenSource(),
                    style: linkStyle,
                  ),
                  onTap: () {
                    launch('https://github.com/bouhormq/CORSA');
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
