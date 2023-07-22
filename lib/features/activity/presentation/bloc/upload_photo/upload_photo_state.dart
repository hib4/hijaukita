part of 'upload_photo_bloc.dart';

@immutable
abstract class UploadPhotoState {}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {}

class UploadPhotoFailure extends UploadPhotoState {
  UploadPhotoFailure({required this.message});

  final String message;
}
