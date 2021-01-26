import 'package:flutter/material.dart';
import 'package:tabatapp/models/task.dart';
import 'package:tabatapp/widgets/workout/preview_card.dart';

class Preview extends StatelessWidget {
  final List<Task> tasks;

  const Preview({Key key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, i) => SizedBox(
          height: 10,
        ),
        itemBuilder: (context, i) => PreviewCard(
          color: tasks[i].color,
          title: tasks[i].title,
          duration: tasks[i].durationToString(),
        ),
        itemCount: tasks.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
