import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'layouts/about.dart';
import 'layouts/home.dart';
import 'layouts/login.dart';
import 'layouts/splashscreen.dart';
import 'models/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges()),
        ChangeNotifierProvider<GraphAnimationProvider>(
            create: (_) => GraphAnimationProvider()),
        StreamProvider<Preferences>.value(
            initialData: Preferences.empty(),
            value: db.streamPreferences(FirebaseAuth.instance.currentUser?.uid),
            catchError: (_, err) => Preferences.empty()),
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
          Locale('ru', ''), // Russian
          Locale('no', ''), // Norwegian
        ],
        theme: ThemeData(
          colorSchemeSeed: background,
          brightness: Brightness.light,
          useMaterial3: true,
          textTheme: GoogleFonts.oswaldTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme),
          backgroundColor: background,
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme(
            backgroundColor: background,
            foregroundColor: Colors.white,
          ),
          navigationRailTheme: NavigationRailThemeData(
            backgroundColor: primaryVeryLight,
            selectedLabelTextStyle: GoogleFonts.quicksand(color: primaryDark, fontSize: 12, letterSpacing: 1),
            selectedIconTheme: const IconThemeData(color: primaryDark),
            unselectedLabelTextStyle: GoogleFonts.quicksand(color: textSecondary, fontSize: 12, letterSpacing: 1),
            unselectedIconTheme: const IconThemeData(color: textSecondary),
            useIndicator: false,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: primaryVeryLight
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: primaryVeryLight,
            selectedLabelStyle: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1),
            unselectedLabelStyle: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1),
          ),
          cardTheme: const CardTheme(color: primaryDark),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(primaryVeryLight),
              foregroundColor: MaterialStateProperty.all<Color>(textPrimary),
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(primaryVeryLight),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: primaryVeryLight),
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: background,
          brightness: Brightness.dark,
          useMaterial3: true,
          textTheme: GoogleFonts.oswaldTextTheme(
              ThemeData(brightness: Brightness.light).textTheme),
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
          navigationRailTheme: NavigationRailThemeData(
            selectedLabelTextStyle: TextStyle(color: primaryLight, fontFamily: GoogleFonts.oswald().fontFamily),
            selectedIconTheme: const IconThemeData(color: primaryLight),
            unselectedLabelTextStyle: TextStyle(fontFamily: GoogleFonts.oswald().fontFamily),
            useIndicator: false,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: GoogleFonts.quicksand(color: background, fontSize: 12, letterSpacing: 1),
            selectedIconTheme: const IconThemeData(color: primaryLight),
            unselectedLabelStyle: GoogleFonts.quicksand(color: background, fontSize: 12, letterSpacing: 1),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(primaryVeryLight),
              backgroundColor: MaterialStateProperty.all<Color>(background),
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 55)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(primaryVeryLight),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(color: primaryVeryLight),
              ),
            ),
          ),
        ),
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
