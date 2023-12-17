part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}



final class SignUpLoading extends SignUpInitial {}

final class SignUpSuccess extends SignUpInitial {}

final class SignUpFailure extends SignUpInitial {}

final class SignUpError extends SignUpInitial {}
