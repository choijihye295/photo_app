import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


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
    'add_frame', //사용자 프레임 추가 마커
  ];

  int currentIndex = 0;

  Future<void> _pickCustomFrame() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        //사용자 이미지 경로를 'add_frame' 앞에 추가
        framePaths.insert(framePaths.length - 1, picked.path);
        currentIndex = framePaths.length - 2; //추가한 프레임을 선택 상태로
      });
    }
  }

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

  Widget _buildFramePreview(String path) {
    if (path == 'add_frame') {
      return GestureDetector(
        onTap: _pickCustomFrame,
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: const Center(
            child: Icon(Icons.add, size: 50, color: Colors.grey),
          ),
        ),
      );
    }

    //사용자 프레임일 경우 탭하면 교체 가능하게
    if (!path.startsWith('assets/')) {
      return GestureDetector(
        onTap: () async {
          final picker = ImagePicker();
          final picked = await picker.pickImage(source: ImageSource.gallery);
          if (picked != null) {
            setState(() {
              framePaths[currentIndex] = picked.path; // 현재 위치의 사용자 프레임 교체
            });
          }
        },
        child: Image.file(File(path), width: 200, height: 300, fit: BoxFit.contain),
      );
    }

    // 기본 프레임
    return Image.asset(path, width: 200, height: 300, fit: BoxFit.contain);
  }


  String _frameLabel(String path, int index) {
    if (path == 'add_frame') return '프레임 추가';
    if (path == 'assets/frames/none.png') return '프레임 없음';
    if (path.startsWith('assets/')) return '프레임 ${index}번';
    return '사용자 프레임';
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = framePaths[currentIndex];

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
              _buildFramePreview(currentPath),
              IconButton(onPressed: _nextFrame, icon: const Icon(Icons.arrow_right)),
            ],
          ),
          const SizedBox(height: 16),
          Text(_frameLabel(currentPath, currentIndex)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: currentPath == 'add_frame'
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(selectedFramePath: currentPath),
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