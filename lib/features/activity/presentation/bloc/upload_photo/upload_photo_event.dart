part of 'upload_photo_bloc.dart';

@immutable
abstract class UploadPhotoEvent {}

class PostUploadPhotoEvent extends UploadPhotoEvent {
  PostUploadPhotoEvent({
    required this.activityId,
    required this.desc,
    required this.photo,
  });

  final int activityId;
  final String desc;
  final String photo;
}
