import 'package:flutter/material.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/card_tile.dart';

class MenuScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    var entries = [
      {'name': 'Entrainements', 'to': '/trainings', 'icon': Icons.run_circle},
      {'name': 'Creer', 'to': '/create', 'icon': Icons.create},
      {'name': 'Statistiques', 'to': '/stats', 'icon': Icons.bar_chart},
    ];
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Menu',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
        ));
  }
}
