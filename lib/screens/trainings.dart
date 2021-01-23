import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/screens/training.dart';
import 'package:tabatapp/store/trainings.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/card_tile.dart';

class TrainingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trainings = watch(trainingsProvider.state);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Menu',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          itemCount: trainings.length,
          separatorBuilder: (context, _) {
            return SizedBox(height: 5);
          },
          itemBuilder: (context, i) {
            var training = trainings[i];
            return CardTile(
              title: training.name,
              subtitle: training.totalDuration(),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white70,
                ),
                onPressed: () {
                  context.read(trainingsProvider).remove(training.id);
                },
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TrainingScreen(training: training)));
              },
            );
          },
        ),
      ),
    );
  }
}
