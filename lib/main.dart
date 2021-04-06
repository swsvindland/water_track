import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/layouts/layouts.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';

final _kTestingCrashlytics = false;

Future<void> _initializeFlutterFire() async {
  await Firebase.initializeApp();

  if (_kTestingCrashlytics) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  Function originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    originalOnError(errorDetails);
  };
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFlutterFire();

  runZonedGuarded(() {
    runApp(App());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
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
        title: 'Water Track',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreenPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage()
        },
      ),
    );
  }
}
