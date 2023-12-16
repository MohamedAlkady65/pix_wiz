part of 'adjust_cubit.dart';

@immutable
sealed class AdjustState {}

final class AdjustInitial extends AdjustState {}

final class AdjustChangeChoice extends AdjustState {}

final class AdjustAction extends AdjustState {}

final class AdjustLoading extends AdjustState {}
