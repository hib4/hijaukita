import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/theme/color_values.dart';
import '../../../../../core/util/painter/object_detector_painter.dart';
import '../../../../../core/widgets/dialog/information_dialog.dart';
import '../../bloc/classifier/classifier_bloc.dart';
import '../upload_photo/photo_bottom_sheet.dart';

class PhotoContainerWidget extends StatelessWidget {
  const PhotoContainerWidget({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<ClassifierBloc, ClassifierState>(
      listener: (context, state) {
        if (state is ClassifierFailure) {
          showDialog(
            context: context,
            builder: (_) => informationDialog(
              context,
              title: 'Objek tidak terdeteksi',
              message: 'Silahkan ambil ulang dengan foto yang lebih jelas.',
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ClassifierLoading) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.file(
                  File(state.path),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ClassifierSuccess) {
          return CustomPaint(
            foregroundPainter: ObjectDetectorPainter(
              state.size,
              state.detectedObject,
            ),
            child: AspectRatio(
              aspectRatio: state.size.aspectRatio,
              child: _buildPhoto(context, textTheme, path: state.path),
            ),
          );
        } else if (state is ClassifierFailure) {
          return _buildPhoto(context, textTheme, path: state.path);
        }
        return _buildUploadPhoto(context);
      },
    );
  }

  Widget _buildPhoto(BuildContext context, TextTheme textTheme,
      {required String path}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.file(
            File(path),
          ),
          Positioned.fill(
            top: 16,
            right: 16,
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => photoBottomSheet(context, category),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ambil Ulang',
                      style: textTheme.bodySmall!.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPhoto(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorValues.grey01,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.icons.uploadPhoto.svg(),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => photoBottomSheet(context, category),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(128, 48),
            ),
            child: const Text('Unggah foto'),
          ),
        ],
      ),
    );
  }
}
