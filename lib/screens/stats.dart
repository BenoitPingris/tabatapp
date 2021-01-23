import 'package:flutter/material.dart';
import 'package:tabatapp/widgets/appbar.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Stats',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'stats',
            ),
          ],
        ),
      ),
    );
  }
}
