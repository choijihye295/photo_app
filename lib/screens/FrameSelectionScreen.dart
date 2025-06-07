import 'package:flutter/material.dart';
import 'home_screen.dart';

class FrameSelectionScreen extends StatefulWidget {
  const FrameSelectionScreen({super.key});

  @override
  State<FrameSelectionScreen> createState() => _FrameSelectionScreenState();
}

class _FrameSelectionScreenState extends State<FrameSelectionScreen> {
  final List<String> framePaths = [
    'assets/frames/none.png',     // 프레임 없음
    'assets/frames/frame1.png',
    'assets/frames/frame2.png',
    'assets/frames/frame3.png',
  ];

  int currentIndex = 0;

  void _nextFrame() {
    setState(() {
      currentIndex = (currentIndex + 1) % framePaths.length;
    });
  }

  void _previousFrame() {
    setState(() {
      currentIndex = (currentIndex - 1 + framePaths.length) % framePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프레임 선택')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('프레임을 선택하세요'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _previousFrame, icon: const Icon(Icons.arrow_left)),
              Image.asset(
                framePaths[currentIndex],
                width: 200,
                height: 300,
                fit: BoxFit.contain,
              ),
              IconButton(onPressed: _nextFrame, icon: const Icon(Icons.arrow_right)),
            ],
          ),
          const SizedBox(height: 16),
          Text(currentIndex == 0 ? '프레임 없음' : '프레임 ${currentIndex}번'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(selectedFramePath: framePaths[currentIndex]),
                ),
              );
            },
            child: const Text('다음'),
          ),
        ],
      ),
    );
  }
}