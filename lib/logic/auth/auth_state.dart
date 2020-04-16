import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class LoggedOutAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoggedInAuthState extends AuthState {
  @override
  List<Object> get props => [];
}