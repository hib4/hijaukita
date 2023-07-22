part of 'classifier_bloc.dart';

@immutable
abstract class ClassifierState {}

class ClassifierInitial extends ClassifierState {}

class ClassifierLoading extends ClassifierState {
  ClassifierLoading({required this.path});

  final String path;
}

class ClassifierSuccess extends ClassifierState {
  ClassifierSuccess({
    required this.path,
    required this.size,
    required this.detectedObject,
  });

  final String path;
  final Size size;
  final DetectedObject detectedObject;
}

class ClassifierFailure extends ClassifierState {
  ClassifierFailure({required this.path});

  final String path;
}
