part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileSuccess({required this.profile});

  final Profile profile;
}

class ProfileFailure extends ProfileState {
  ProfileFailure({required this.message});

  final String message;
}
