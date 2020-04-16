import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_event.dart';
import 'package:fluttertrainer2/logic/auth/bloc.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthBloc authBloc;
  Dio dio;

  LoginBloc(this.authBloc){
    BaseOptions options = new BaseOptions(
      baseUrl: "https://gorest.co.in/public-api",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Authorization" : "Bearer -EjGASQM2qGy6US3fO11r8eQJ9-Fnr1u2o0P"
      },
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

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
    if (name?.isNotEmpty == true && lastName?.isNotEmpty == true) {
      yield LoginInProgress();
      try {
        Response response = await dio.get("/users?first_name=$name&last_name=$lastName");
        if (response.data["_meta"]["success"] == true) {
          if (response.data["result"].isNotEmpty) {
            User user = User.fromJson(response.data["result"][0]);
            yield LoginSuccess();
            authBloc.add(LogInAuthEvent(user));
          } else {
            yield LoginError("Niepoprawne dane logowania");
          }
        } else {
          yield LoginError("Błędny request");
        }
      } catch (e) {
        yield LoginError(e.toString());
      }
    } else {
      yield LoginError("Brak danych");
    }
  }
}
