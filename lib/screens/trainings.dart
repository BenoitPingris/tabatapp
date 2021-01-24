import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/training.dart';
import 'package:tabatapp/screens/training.dart';
import 'package:tabatapp/store/trainings.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/card_tile.dart';

class TrainingsScreen extends StatefulWidget {
  @override
  _TrainingsScreenState createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  List<Training> trainings = [];
  fetchTrainings() {
    Training.fetch().then((d) {
      setState(() {
        trainings = d;
      });
    });
  }

  @override
  void initState() {
    fetchTrainings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Entraînements',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Builder(builder: (_) {
          if (trainings.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/empty.png')),
                Container(
                  child: Text(
                    'Vous n\'avez pas d\'entraînements crées !',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Creer'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create');
                  },
                )
              ],
            ));
          }
          return ListView.separated(
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
                  onPressed: () async {
                    await training.remove();
                    fetchTrainings();
                  },
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TrainingScreen(training: training)));
                  fetchTrainings();
                },
              );
            },
          );
        }),
      ),
    );
  }
}
