import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final MaterialColor color;
  final String title;
  final String duration;
  const PreviewCard(
      {Key key,
      @required this.color,
      @required this.title,
      @required this.duration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color[50],
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: color[800], fontSize: 20)),
            Text(duration, style: TextStyle(color: color[800], fontSize: 15))
          ],
        ),
      ),
    );
  }
}
