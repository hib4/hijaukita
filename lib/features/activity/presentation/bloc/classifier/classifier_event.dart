part of 'classifier_bloc.dart';

@immutable
abstract class ClassifierEvent {}

class PhotoClassifierEvent extends ClassifierEvent {
  PhotoClassifierEvent({this.isFromCamera = false, required this.category});

  final bool isFromCamera;
  final String category;
}
