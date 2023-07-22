import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../extension/extension.dart';

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter(this.absoluteImageSize, this.element);

  final Size absoluteImageSize;
  final DetectedObject element;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(DetectedObject container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint background = Paint()..color = const Color(0x99000000);

    final ParagraphBuilder builder = ParagraphBuilder(
      ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 16,
        textDirection: TextDirection.ltr,
      ),
    );
    builder.pushStyle(
      ui.TextStyle(
        color: Colors.lightGreenAccent,
        background: background,
      ),
    );

    final text = element.labels.first.text.parseLabel();
    builder.addText(text);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.lightGreenAccent
      ..strokeWidth = 3.0;

    final scale = scaleRect(element);

    canvas.drawRect(scale, paint);
    canvas.drawParagraph(
      builder.build()
        ..layout(
          ParagraphConstraints(width: scale.right - scale.left),
        ),
      Offset(scale.left, scale.top),
    );
  }

  @override
  bool shouldRepaint(ObjectDetectorPainter oldDelegate) => true;
}
