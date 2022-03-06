import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/layouts/layouts.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';

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
