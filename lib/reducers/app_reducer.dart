import 'package:water_track/models/app_state.dart';
import 'count_reducer.dart';
import 'auth_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    count: countReducer(state.count, action),
    currentUser: authReducer(state.currentUser, action),
  );
}

