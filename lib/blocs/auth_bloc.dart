import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}
class Login extends AuthEvent {}
class Logout extends AuthEvent {}

@immutable
abstract class AuthState {}
class SignedIn extends AuthState{}
class SignedOut extends AuthState{}



class CounterBloc extends Bloc<AuthEvent, AuthState> {

  CounterBloc() : super(SignedOut()) {
    on<Login>((event, emit) => emit(SignedIn()));
    on<Logout>((event, emit) => emit(SignedOut()));
  }
}