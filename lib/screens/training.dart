import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabatapp/models/task.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/training/clock.dart';
import 'package:tabatapp/widgets/training/controls.dart';
import 'package:tabatapp/widgets/training/preview.dart';
import 'package:tabatapp/models/training.dart';

class TrainingScreen extends StatefulWidget {
  final Training training;

  const TrainingScreen({Key key, @required this.training}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  List<Task> tasks = [];
  int current = 0;

  void generateTasks() {
    setState(() {
      final training = widget.training;
      tasks = [Task('Preparation', training.prepare, Colors.cyan)];
      for (int c in List.generate(training.nbCycles, (i) => i)) {
        for (int i in List.generate(training.nbSeries, (i) => i)) {
          tasks = [
            ...tasks,
            Task('Exercice', training.serieDuration, Colors.blue),
            if (i < training.nbSeries - 1)
              Task('Repos', training.rest, Colors.green)
          ];
        }
        if (c < training.nbCycles - 1)
          tasks = [...tasks, Task('Repos', training.rest * 2, Colors.green)];
      }
    });
  }

  @override
  void initState() {
    generateTasks();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: tasks[current].duration))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (current + 1 >= tasks.length) {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                      content: Text('Entraînements fini !'),
                      actions: [
                        FlatButton(
                          child: Text('Fermer'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ]);
                });
            return;
          }
          current += 1;
          controller.duration = Duration(seconds: tasks[current].duration);
          // controller.duration = Duration(seconds: 10);
          controller.forward(from: 0.0);
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.training.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Clock(
                size: Size(300, 300),
                task: tasks[current],
                controller: controller),
            Preview(tasks: tasks.skip(current).toList()),
            Controls(
              training: widget.training,
              controller: this.controller,
            )
          ],
        ),
      ),
    );
  }
}
