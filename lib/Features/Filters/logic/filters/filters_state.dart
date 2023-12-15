part of 'filters_cubit.dart';

@immutable
sealed class FiltersState {}

final class FiltersInitial extends FiltersState {}

final class FiltersChangeChoice extends FiltersState {}

final class FiltersAction extends FiltersState {}
