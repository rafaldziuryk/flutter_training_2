import 'package:equatable/equatable.dart';

import 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {

  final User user;

  LoginEvent(this.user);

  @override
  List<Object> get props => [user];

}
