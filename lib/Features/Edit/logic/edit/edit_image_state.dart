part of 'edit_image_cubit.dart';

@immutable
sealed class EditImageState {}

final class EditImageInitial extends EditImageState {}

class EditImageResult extends EditImageState {}

final class EditImageLoading extends EditImageState {}

final class EditImageChangeMode extends EditImageState {}
