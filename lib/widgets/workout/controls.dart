import 'package:flutter/material.dart';
import 'package:tabatapp/models/workout.dart';
import 'package:tabatapp/i18n.dart';

class Controls extends StatefulWidget {
  final Workout workout;
  final AnimationController controller;

  const Controls({Key key, this.workout, this.controller}) : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton.icon(
          icon: Icon(Icons.delete_sharp),
          label: Text('delete'.i18n),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('sure to delete'.i18n),
                      actions: [
                        FlatButton(
                          child: Text('cancel'.i18n),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('confirm'.i18n),
                          onPressed: () async {
                            await widget.workout.remove();
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          },
                        )
                      ],
                    ));
          },
        ),
        AnimatedBuilder(
            animation: widget.controller,
            builder: (_, __) {
              return FlatButton.icon(
                  onPressed: () {
                    if (widget.controller.isAnimating) {
                      widget.controller.stop();
                    } else {
                      widget.controller.forward();
                    }
                    setState(() {}); // sad but I have to do that :(
                  },
                  icon: Icon(widget.controller.isAnimating
                      ? Icons.pause
                      : Icons.play_arrow),
                  label: Text(widget.controller.isAnimating
                      ? 'pause'.i18n
                      : 'play'.i18n));
            }),
      ],
    );
  }
}
