import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_event.dart';
import 'package:fluttertrainer2/logic/auth/bloc.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthBloc authBloc;

  LoginBloc(this.authBloc);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is TryToLoginEvent) {
      yield* tryToLogin(event.name, event.lastName);
    }
  }

  Stream<LoginState> tryToLogin(String name, String lastName) async* {
    yield LoginInProgress();
    await Future.delayed(Duration(seconds: 2), () => true);
    yield LoginSuccess();
    authBloc.add(LogInAuthEvent(User()));
  }
}
