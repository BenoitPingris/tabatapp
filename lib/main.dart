import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/screens/create.dart';
import 'package:tabatapp/screens/menu.dart';
import 'package:tabatapp/screens/stats.dart';
import 'package:tabatapp/screens/trainings.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabatapp',
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuScreen(),
        '/create': (context) => CreateScreen(),
        '/trainings': (context) => TrainingsScreen(),
        '/stats': (context) => StatsScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
