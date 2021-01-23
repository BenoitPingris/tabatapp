import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Widget trailing;
  final IconData leading;
  final String subtitle;

  const CardTile(
      {Key key,
      this.onTap,
      this.title,
      this.leading,
      this.trailing,
      this.subtitle})
      : super(key: key);

  Widget buildTile() {
    return ListTile(
        leading: leading != null
            ? Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Icon(leading, color: Colors.white),
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                    color: Colors.white70, fontStyle: FontStyle.italic),
              )
            : null,
        trailing: trailing != null ? trailing : null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 8,
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                  borderRadius: BorderRadius.circular(5)),
              child: buildTile())),
    );
  }
}
