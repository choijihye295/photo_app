import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  final String selectedFramePath;

  const HomeScreen({super.key, required this.selectedFramePath});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<File?> _images = List.generate(4, (_) => null);
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _previewContainerKey = GlobalKey();
  final List<TransformationController> _controllers =
  List.generate(4, (_) => TransformationController());

  Future<void> _pickImage(int index) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images[index] = File(picked.path);
      });
    }
  }

  Future<void> _shareImage() async {
    try {
      RenderRepaintBoundary boundary =
      _previewContainerKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/shared_image.png').create();
        await file.writeAsBytes(pngBytes);

        await Share.shareXFiles([XFile(file.path)], text: '내 네컷사진 함께 봐요!');
      }
    } catch (e) {
      print('공유 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ 공유에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double frameWidth = MediaQuery
        .of(context)
        .size
        .width * 0.8;
    final double frameHeight = frameWidth * 1.5;
    final double cellWidth = frameWidth / 2;
    final double cellHeight = frameHeight / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('네컷사진 만들기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Center( //수평 중앙 정렬
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RepaintBoundary(
                  key: _previewContainerKey,
                  child: SizedBox(
                    width: frameWidth,
                    height: frameHeight,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                _buildImageCell(0, cellWidth, cellHeight),
                                _buildImageCell(1, cellWidth, cellHeight),
                              ],
                            ),
                            Row(
                              children: [
                                _buildImageCell(2, cellWidth, cellHeight),
                                _buildImageCell(3, cellWidth, cellHeight),
                              ],
                            ),
                          ],
                        ),
                        Positioned.fill(
                          child: IgnorePointer( // 프레임은 보이되 제스처는 아래로 전달
                            child: widget.selectedFramePath.endsWith('none.png')
                                ? const SizedBox()
                                : Image.asset(
                              widget.selectedFramePath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(4, (i) {
                    return ElevatedButton(
                      onPressed: () => _pickImage(i),
                      child: Text('${i + 1}번'),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _shareImage,
                  icon: const Icon(Icons.share),
                  label: const Text('공유하기'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildImageCell(int index, double width, double height) {
    return ClipRect( // 셀 외부로 나가지 않게 자르기
      child: SizedBox(
        width: width,
        height: height,
        child: _images[index] != null
            ? InteractiveViewer(
          transformationController: _controllers[index],
          panEnabled: true,
          scaleEnabled: true,
          minScale: 1.0,
          maxScale: 3.0,
          constrained: true,
          // 셀 내부에 맞게 제한
          clipBehavior: Clip.hardEdge,
          // 클리핑 적용
          child: Image.file(
            _images[index]!,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        )
            : Container(
          color: Colors.grey[300],
          child: Center(child: Text('${index + 1}번')),
        ),
      ),
    );
  }
}
