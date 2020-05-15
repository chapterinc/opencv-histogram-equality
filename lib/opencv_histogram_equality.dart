import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class OpencvHistogramEquality {
  static const MethodChannel _channel =
      const MethodChannel('opencv_histogram_equality');

  Future<double> similarity(Uint8List first, Uint8List second) async {
    Map<String, dynamic> values = {'first': first, 'second': second};
    LinkedHashMap<dynamic, dynamic> map =
        await _channel.invokeMethod("similarity", values);

    if (map["error"] != null) {
      throw Exception("create object finished with exception ${map["error"]}");
    }

    return values["similarity"];
  }
}
