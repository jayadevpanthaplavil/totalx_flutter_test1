import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  int milliseconds;
  Timer? _timer;

  Debounce._({this.milliseconds = 800});

  // Singleton instance
  static final Debounce _singleton = Debounce._();

  factory Debounce({int milliseconds = 800}) {
    _singleton.milliseconds = milliseconds;
    return _singleton;
  }

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
