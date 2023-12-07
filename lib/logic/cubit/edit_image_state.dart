part of 'edit_image_cubit.dart';

@immutable
sealed class EditImageState {}

final class EditImageInitial extends EditImageState {}

sealed class EditImageResult extends EditImageState {
  final Uint8List image;
  EditImageResult(this.image);
}

final class EditImageOriginal extends EditImageResult {
  EditImageOriginal(super.image);
}

final class EditImageEdited extends EditImageResult {
  EditImageEdited(super.image);
}

final class EditImageLoading extends EditImageState {}
