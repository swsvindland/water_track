import 'package:flutter/material.dart';
import 'package:water_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about, style: const TextStyle(color: Colors.white)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: sm.toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.aboutPageCredits,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Text(
                  'Sam Svindland',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 36),
                Text(
                  AppLocalizations.of(context)!.aboutPageVersion,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Text(
                  '2.1.1',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
