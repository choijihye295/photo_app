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
      title: '네컷사진 만들기',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const FrameSelectionScreen(), // 시작화면 변경
    );
  }
}
