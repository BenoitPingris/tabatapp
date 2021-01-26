import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabatapp/models/task.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/workout/clock.dart';
import 'package:tabatapp/widgets/workout/controls.dart';
import 'package:tabatapp/widgets/workout/preview.dart';
import 'package:tabatapp/models/workout.dart';
import 'package:tabatapp/i18n.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutScreen({Key key, @required this.workout}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  List<Task> tasks = [];
  int current = 0;

  void generateTasks() {
    setState(() {
      final workout = widget.workout;
      tasks = [Task('preparation'.i18n, workout.prepare, Colors.cyan)];
      for (int c in List.generate(workout.nbCycles, (i) => i)) {
        for (int i in List.generate(workout.nbSeries, (i) => i)) {
          tasks = [
            ...tasks,
            Task('exercise'.i18n, workout.serieDuration, Colors.blue),
            if (i < workout.nbSeries - 1)
              Task('rest'.i18n, workout.rest, Colors.green)
          ];
        }
        if (c < workout.nbCycles - 1)
          tasks = [...tasks, Task('rest'.i18n, workout.rest * 2, Colors.green)];
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
                      content: Text('workout finished'.i18n),
                      actions: [
                        FlatButton(
                          child: Text('close'.i18n),
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
        title: widget.workout.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Clock(
                size: Size(300, 300),
                task: tasks[current],
                controller: controller),
            Preview(tasks: tasks.skip(current).toList()),
            Controls(
              workout: widget.workout,
              controller: this.controller,
            )
          ],
        ),
      ),
    );
  }
}
