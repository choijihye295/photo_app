import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/FrameSelectionScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '인생네컷 앱',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const FrameSelectionScreen(), // 시작화면 변경
    );
  }
}
