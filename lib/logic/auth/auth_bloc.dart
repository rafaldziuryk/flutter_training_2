import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fluttertrainer2/logic/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => LoggedOutAuthState();

  AuthBloc(){
    add(LoginFromCacheAuthEvent());
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is LogInAuthEvent) {
      yield* loginEvent(event.user);
    } else if (event is LogOutAuthEvent) {
      yield* logOutEvent();
    } else if (event is LoginFromCacheAuthEvent) {
      yield* loginFromCacheEvent();
    }
  }

  Stream<AuthState> loginEvent(User user) async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList("user", [user.firstName, user.lastName, user.rawRoles]);
    yield LoggedInAuthState(user);
  }

  Stream<AuthState> logOutEvent() async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("user");
    yield LoggedOutAuthState();
  }

  Stream<AuthState> loginFromCacheEvent() async* {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("user")) {
      List<String> userData = sharedPreferences.getStringList("user");
      User user = User(firstName: userData[0], lastName: userData[1], rawRoles: userData[2]);
      yield LoggedInAuthState(user);
    }
  }
}
