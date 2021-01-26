import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/i18n.dart';
import 'package:tabatapp/screens/create.dart';
import 'package:tabatapp/screens/menu.dart';
import 'package:tabatapp/screens/stats.dart';
import 'package:tabatapp/screens/workouts.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'fr',
      supportedLocales: ['fr', 'en'],
      preferences: TranslatePreferences());
  runApp(
    LocalizedApp(
      delegate,
      ProviderScope(
        child: MyApp(),
      ),
    ),
  );
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
        '/workouts': (context) => WorkoutsScreen(),
        '/stats': (context) => StatsScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
