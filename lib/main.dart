import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:water_track/layouts/layouts.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges()),
        ChangeNotifierProvider<GraphAnimationProvider>(
            create: (_) => GraphAnimationProvider()),
      ],
      child: MaterialApp(
        title: 'WaterTrack',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English
          Locale('es', ''), // Spanish
          Locale('pt', ''), // Portuguese
          Locale('fr', ''), // French
          Locale('de', ''), // German
          Locale('it', ''), // Italian
          Locale('zh', ''), // Simplified Chinese
          Locale('ko', ''), // Korean
          Locale('ja', ''), // Japanese
          Locale('ar', ''), // Arabic
          Locale('hi', ''), // Hindi
        ],
        theme: ThemeData(
            colorSchemeSeed: Colors.lightBlue,
            brightness: Brightness.light,
            useMaterial3: true,
            backgroundColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.lightBlue,
            primaryTextTheme: TextTheme(
                headline1: TextStyle(color: Colors.white),
                headline2: TextStyle(color: Colors.white),
                headline3: TextStyle(color: Colors.white),
                headline4: TextStyle(color: Colors.white),
                headline5: TextStyle(color: Colors.white),
                headline6: TextStyle(color: Colors.white),
                subtitle1: TextStyle(color: Colors.white),
                subtitle2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white)),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.lightBlue,
            brightness: Brightness.dark,
            useMaterial3: true,
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            primaryTextTheme: TextTheme(
                headline1: TextStyle(color: Colors.white),
                headline2: TextStyle(color: Colors.white),
                headline3: TextStyle(color: Colors.white),
                headline4: TextStyle(color: Colors.white),
                headline5: TextStyle(color: Colors.white),
                headline6: TextStyle(color: Colors.white),
                subtitle1: TextStyle(color: Colors.white),
                subtitle2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.black, foregroundColor: Colors.white)),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => SplashScreenPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/about': (context) => AboutPage(),
        },
      ),
    );
  }
}
