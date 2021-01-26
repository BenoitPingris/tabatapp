import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:tabatapp/i18n.dart';
import 'package:tabatapp/screens/create.dart';
import 'package:tabatapp/screens/menu.dart';
import 'package:tabatapp/screens/stats.dart';
import 'package:tabatapp/screens/workouts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadTranslations();
  //TODO fetch the saved locale and/or the device locale
  runApp(
    ProviderScope(
      child: I18n(
        initialLocale: Locale('fr'),
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
      theme: ThemeData(primarySwatch: Colors.brown),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'),
        const Locale('en'),
      ],
    );
  }
}
