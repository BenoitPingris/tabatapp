import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/store/trainings.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/training/clock.dart';
import 'package:tabatapp/widgets/training/preview.dart';
import 'package:tabatapp/models/training.dart';

class TrainingScreen extends ConsumerWidget {
  final Training training;

  const TrainingScreen({Key key, @required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: CustomAppBar(
        title: training.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: Text(training.totalDuration(),
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            Preview(training: training),
            ButtonBar(
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
                                  'Etes-vous sur de vouloir supprimer cet entrainement ?'),
                              actions: [
                                FlatButton(
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Confirmer'),
                                  onPressed: () {
                                    context
                                        .read(trainingsProvider)
                                        .remove(training.id);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Lancer'),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
