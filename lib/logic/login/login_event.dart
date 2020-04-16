import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class TryToLoginEvent extends LoginEvent {

  final String name;
  final String lastName;

  TryToLoginEvent(this.name, this.lastName);

  @override
  List<Object> get props => [name, lastName];

}
