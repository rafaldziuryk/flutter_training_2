import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttertrainer2/logic/auth/user.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => LoggedOutAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is LoginEvent) {
      yield* loginEvent(event.user);
    }
  }

  Stream<AuthState> loginEvent(User user) async* {
    yield LoggedInAuthState();
  }
}
