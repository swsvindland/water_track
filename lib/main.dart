import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
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
            colorSchemeSeed: background,
            brightness: Brightness.light,
            useMaterial3: true,
            textTheme: GoogleFonts.oswaldTextTheme(),
            backgroundColor: background,
            scaffoldBackgroundColor: background,
            appBarTheme: const AppBarTheme(
                backgroundColor: background,
                foregroundColor: Colors.white,
            ),
            cardTheme: const CardTheme(
              color: primaryDark
            )
        ),
        darkTheme: ThemeData(
            colorSchemeSeed: background,
            brightness: Brightness.dark,
            useMaterial3: true,
            textTheme: GoogleFonts.oswaldTextTheme(),
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black, foregroundColor: Colors.white)),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashscreenPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
        },
      ),
    );
  }
}
