import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:tabatapp/models/workout.dart';

class Controls extends StatefulWidget {
  final Workout workout;
  final AnimationController controller;

  Controls({this.workout, this.controller, Key key}) : super(key: key);

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
          label: Text(translate('delete')),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text(translate('sure to delete')),
                      actions: [
                        FlatButton(
                          child: Text(translate('cancel')),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(translate('confirm')),
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
                      ? translate('pause')
                      : translate('play')));
            }),
      ],
    );
  }
}
