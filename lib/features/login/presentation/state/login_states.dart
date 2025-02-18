abstract class LoginState{}

class LoginInitialState implements LoginState{
}

class LoginLoadingState implements LoginState{
}

class LoginLoginState implements LoginState{
  final String email;
  final String number;

  LoginLoginState(this.email, this.number);
}

class LoginSuccessState implements LoginState{
  final String number;
  LoginSuccessState(this.number);
}

class LoginFailureState implements LoginState{
  final String message;

  LoginFailureState(this.message);
}