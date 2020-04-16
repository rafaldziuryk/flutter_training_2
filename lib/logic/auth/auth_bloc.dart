import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttertrainer2/logic/auth/user.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => LoggedOutAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is LogInAuthEvent) {
      yield* loginEvent(event.user);
    } else if (event is LogOutAuthEvent) {
      yield* logOutEvent();
    }
  }

  Stream<AuthState> loginEvent(User user) async* {
    yield LoggedInAuthState();
  }

  Stream<AuthState> logOutEvent() async* {
    yield LoggedOutAuthState();
  }
}
