import 'package:flutter/material.dart';
import 'package:tabatapp/models/task.dart';
import 'package:tabatapp/models/training.dart';
import 'package:tabatapp/widgets/training/preview_card.dart';

class Preview extends StatefulWidget {
  final Training training;

  const Preview({Key key, this.training}) : super(key: key);

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  List<Task> _tasks = [];
  @override
  void initState() {
    generateTasks();
    super.initState();
  }

  void generateTasks() {
    setState(() {
      final training = widget.training;
      _tasks = [Task('Preparation', training.prepare, Colors.cyan)];
      for (int c in List.generate(training.nbCycle, (i) => i)) {
        for (int i in List.generate(training.nbSeries, (i) => i)) {
          _tasks = [
            ..._tasks,
            Task('Exercice', training.timeSerie, Colors.blue),
            if (i < training.nbSeries - 1)
              Task('Repos', training.rest, Colors.green)
          ];
        }
        if (c < training.nbCycle - 1)
          _tasks = [..._tasks, Task('Repos', training.rest * 2, Colors.green)];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, i) => SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) => PreviewCard(
          color: _tasks[i].color,
          title: _tasks[i].title,
          duration: _tasks[i].durationToString(),
        ),
        itemCount: _tasks.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
