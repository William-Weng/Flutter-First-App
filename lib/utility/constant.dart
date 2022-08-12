import 'dart:developer';

import 'package:flutter/material.dart';

enum TransitionPosition {
  leftToRight,
  rightToLft,
  topToBottom,
  bottomToTop,
  none,
}

extension TransitionPositionExtension on TransitionPosition {
  Tween<Offset> get offset => _offset();

  Tween<Offset> _offset() {
    Tween<Offset> tween = Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    );

    switch (this) {
      case TransitionPosition.leftToRight:
        tween = Tween(
          begin: const Offset(-1.0, 0.0),
          end: const Offset(0.0, 0.0),
        );
        break;

      case TransitionPosition.rightToLft:
        tween = Tween(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        );
        break;

      case TransitionPosition.topToBottom:
        tween = Tween(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        );
        break;

      case TransitionPosition.bottomToTop:
        tween = Tween(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        );
        break;

      case TransitionPosition.none:
        tween = Tween(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        );
        break;
    }

    return tween;
  }
}
