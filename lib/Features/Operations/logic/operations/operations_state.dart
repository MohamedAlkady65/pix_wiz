part of 'operations_cubit.dart';

@immutable
sealed class OperationsState {}

final class OperationsInitial extends OperationsState {}
final class OperationsAction extends OperationsState {}
final class OperationsLoading extends OperationsState {}
