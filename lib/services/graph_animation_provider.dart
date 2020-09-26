import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class GraphAnimationProvider with ChangeNotifier {
  bool _animate;

  bool get animate => _animate;

  void setAnimate(bool animate) {
    this._animate = animate;
  }
}
