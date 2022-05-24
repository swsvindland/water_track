import 'package:flutter/foundation.dart';

class GraphAnimationProvider with ChangeNotifier {
  bool _animate = true;

  bool get animate => _animate;

  void setAnimate(bool animate) {
    _animate = animate;
  }
}
