import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/training.dart';
import 'package:tabatapp/store/trainings.dart';

class Controls extends StatefulWidget {
  final Training training;
  final AnimationController controller;

  Controls({this.training, this.controller, Key key}) : super(key: key);

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
          label: Text('Supprimer'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text(
                          'Etes-vous sûr de vouloir supprimer cet entraînement ?'),
                      actions: [
                        FlatButton(
                          child: Text('Annuler'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('Confirmer'),
                          onPressed: () async {
                            await widget.training.remove();
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
                  label:
                      Text(widget.controller.isAnimating ? "Pause" : "Lancer"));
            }),
      ],
    );
  }
}
