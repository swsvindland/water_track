import 'package:water_track/actions/counter_actions.dart';

int countReducer(int currentCount, action) {
  if(action is IncrementCountAction) {
    currentCount++;
    return currentCount;
  } else if(action is DecrementCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}