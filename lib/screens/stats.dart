import 'package:flutter/material.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/i18n.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: 'statistics'.i18n,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/building_blocks.png'),
            ),
            Text(
              'in progress'.i18n,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
