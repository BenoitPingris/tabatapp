import 'package:flutter/material.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/card_tile.dart';
import 'package:tabatapp/i18n.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = [
      {'name': 'workouts'.i18n, 'to': '/workouts', 'icon': Icons.run_circle},
      {'name': 'create'.i18n, 'to': '/create', 'icon': Icons.create},
      {'name': 'statistics'.i18n, 'to': '/stats', 'icon': Icons.bar_chart},
    ];
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Tabatapp',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Expanded(
              child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (context, i) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, i) {
                  var entry = entries[i];
                  return CardTile(
                    onTap: () {
                      Navigator.pushNamed(context, entry['to']);
                    },
                    leading: entry['icon'],
                    trailing:
                        Icon(Icons.arrow_right, color: Colors.white, size: 30),
                    title: entry['name'],
                  );
                },
              ),
            ),
            FlatButton(
                onPressed: () {
                  showAboutDialog(
                      context: context, applicationVersion: '1.0.0');
                },
                child: Text('more info'.i18n))
          ]),
        ));
  }

  Widget buildTile(entry) {
    return ListTile(
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(entry['icon'], color: Colors.white),
        ),
        title: Text(
          entry['name'],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
  }
}
