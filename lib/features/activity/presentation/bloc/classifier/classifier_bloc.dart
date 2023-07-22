import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../core/util/classifier/classifier.dart';

part 'classifier_event.dart';

part 'classifier_state.dart';

class ClassifierBloc extends Bloc<ClassifierEvent, ClassifierState> {
  ClassifierBloc() : super(ClassifierInitial()) {
    on<PhotoClassifierEvent>(_photoClassifierHandler);
  }

  final Classifier _classifier = Classifier();

  @override
  Future<void> close() {
    _classifier.close();
    return super.close();
  }

  Future<void> _photoClassifierHandler(
    PhotoClassifierEvent event,
    Emitter emit,
  ) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: event.isFromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      emit(ClassifierLoading(path: image.path));
      try {
        final size = await _classifier.getImageSize(image.path);
        final inputImage = InputImage.fromFilePath(image.path);
        final detectedObject = await _classifier.recognizeImage(
          inputImage,
          event.category,
        );
        emit(ClassifierSuccess(
          path: image.path,
          size: size,
          detectedObject: detectedObject,
        ));
      } on Exception {
        emit(ClassifierFailure(path: image.path));
      }
    }
  }
}
