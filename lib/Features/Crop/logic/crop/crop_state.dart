part of 'crop_cubit.dart';

@immutable
sealed class CropState {}

final class CropInitial extends CropState {}
final class CropImageLoading extends CropState {}
final class CropImageAction extends CropState {}
