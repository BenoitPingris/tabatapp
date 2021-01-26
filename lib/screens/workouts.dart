import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:tabatapp/models/workout.dart';
import 'package:tabatapp/screens/workout.dart';
import 'package:tabatapp/widgets/appbar.dart';
import 'package:tabatapp/widgets/card_tile.dart';

class WorkoutsScreen extends StatefulWidget {
  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  List<Workout> workouts = [];
  fetchWorkouts() {
    Workout.fetch().then((d) {
      setState(() {
        workouts = d;
      });
    });
  }

  @override
  void initState() {
    fetchWorkouts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: translate('workouts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Builder(builder: (_) {
          if (workouts.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/empty.png')),
                Container(
                  child: Text(
                    translate('no workouts created'),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text(translate('create')),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create');
                  },
                )
              ],
            ));
          }
          return ListView.separated(
            itemCount: workouts.length,
            separatorBuilder: (context, _) {
              return SizedBox(height: 5);
            },
            itemBuilder: (context, i) {
              var workout = workouts[i];
              return CardTile(
                title: workout.name,
                subtitle: workout.totalDuration(),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white70,
                  ),
                  onPressed: () async {
                    await workout.remove();
                    fetchWorkouts();
                  },
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WorkoutScreen(workout: workout)));
                  fetchWorkouts();
                },
              );
            },
          );
        }),
      ),
    );
  }
}
