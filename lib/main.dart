import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'models/app_state.dart';
import 'reducers/app_reducer.dart';
import 'pages/home_page.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Me Suite';

  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [new LoggingMiddleware.printer()],
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: title,
        home: new HomePage(title),
      ),
    );
  }
}