import 'package:flutter/material.dart';

var blue = Colors.blue[800];
var disabled = Colors.grey;

class RoundedIcon extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final bool enable;

  const RoundedIcon({Key key, this.onPressed, this.icon, this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: enable ? blue : disabled, width: 2.0)),
        child: IconButton(
            padding: EdgeInsets.all(2),
            iconSize: 30,
            constraints: BoxConstraints(),
            color: blue,
            icon: Icon(icon),
            onPressed: enable ? onPressed : null));
  }
}

class NumberInput extends StatelessWidget {
  final String value;
  final String label;
  final Function(int) notify;
  final List<bool> enable;
  final bool separator;

  const NumberInput(
      {Key key,
      @required this.value,
      this.notify,
      this.label,
      this.separator = true,
      this.enable = const [true, true]})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            RoundedIcon(
                enable: enable[0],
                onPressed: () {
                  notify(-1);
                },
                icon: Icons.remove),
            Expanded(
              child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 26),
                  )),
            ),
            RoundedIcon(
                enable: enable[1],
                onPressed: () {
                  notify(1);
                },
                icon: Icons.add),
          ],
        ),
        if (separator)
          Container(
            width: double.infinity,
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 15),
            color: Colors.grey[400],
          )
      ],
    );
  }
}
