import 'package:water_track/models/app_state.dart';
import 'count_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    count: countReducer(state.count, action),
  );
}

