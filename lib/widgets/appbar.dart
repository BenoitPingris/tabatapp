import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  const CustomAppBar({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.chevron_left),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
    );
  }
}
