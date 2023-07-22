import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../extension/extension.dart';
import '../../gen/assets.gen.dart';

class Classifier {
  Classifier() {
    _initializeDetector();
  }

  late ObjectDetector _objectDetector;

  Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    } else {
      throw Exception();
    }
    return file.path;
  }

  Future<void> _initializeDetector() async {
    final path = Assets.tflite.model;
    final modelPath = await _getModel(path);
    final options = LocalObjectDetectorOptions(
      mode: DetectionMode.single,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);
  }

  Future<Size> getImageSize(String imagePath) async {
    final Completer<Size> completer = Completer<Size>();

    final file = File(imagePath);
    final img = Image.file(file);
    img.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          completer.complete(Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          ));
        },
      ),
    );

    final imageSize = await completer.future;

    return imageSize;
  }

  Future<DetectedObject> recognizeImage(
    InputImage inputImage,
    String category,
  ) async {
    final objects = await _objectDetector.processImage(inputImage);
    for (var detectedObject in objects) {
      for (var label in detectedObject.labels) {
        log('${label.text} ${label.confidence}');
        final text = label.text.parseLabel();
        log(text);
        if (text == category && label.confidence >= 0.7) {
          return detectedObject;
        }
      }
    }
    throw Exception();
  }

  void close() {
    _objectDetector.close();
  }
}
