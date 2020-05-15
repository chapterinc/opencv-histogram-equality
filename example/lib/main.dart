import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:opencv_histogram_equality/opencv_histogram_equality.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    checkSimilairtyTestImages();
  }

  Future<void> checkSimilairtyTestImages() async {
    ByteData first = await rootBundle.load('assets/images/cup.jpg');
    ByteData second = await rootBundle.load('assets/images/cup2.jpg');

    OpencvHistogramEquality()
        .similarity(first.buffer.asUint8List(), second.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
