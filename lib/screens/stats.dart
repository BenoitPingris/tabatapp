import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:tabatapp/widgets/appbar.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: translate('statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/building_blocks.png'),
            ),
            Text(
              translate('in progress'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
