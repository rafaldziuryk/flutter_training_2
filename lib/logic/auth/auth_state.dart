import 'package:equatable/equatable.dart';
import 'package:fluttertrainer2/logic/auth/bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class LoggedOutAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoggedInAuthState extends AuthState {

  final User user;

  LoggedInAuthState(this.user);

  @override
  List<Object> get props => [];
}