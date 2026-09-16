part of 'login_cubit.dart';

sealed class LoginState {
  final TokenModel? token;
  final bool toHider;

  const LoginState({this.token, this.toHider = true});
}

final class LoginInitial extends LoginState {
  const LoginInitial({required super.toHider});
}

final class LoginLoding extends LoginState {
  const LoginLoding({required super.toHider, required super.token});
}

final class LoginFinish extends LoginState {
  const LoginFinish({required super.token, required super.toHider});
}

final class LoginSignOut extends LoginState {
  const LoginSignOut({required super.toHider, required super.token});
}

final class LoginButton extends LoginState {
  const LoginButton({required super.toHider, required super.token});
}

final class LoginError extends LoginState {
  final TokenErorrModel error;
  const LoginError({
    required this.error,
    required super.toHider,
    required super.token,
  });
}
