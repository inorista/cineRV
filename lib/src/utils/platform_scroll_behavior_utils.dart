import 'dart:io';

import 'package:flutter/material.dart';

class PlatformScrollBehaviorUtils {
  static ScrollPhysics getPlatformScrollBehavior() {
    if (Platform.isIOS) {
      return const BouncingScrollPhysics();
      ;
    } else {
      return const ClampingScrollPhysics();
    }
  }
}
