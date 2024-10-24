
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:mobile_app/features/login/presentation/state/login_states.dart';

class LoginBloc extends Cubit<LoginState>{

  final LoginUseCase _loginUseCase;

  LoginBloc(
    this._loginUseCase,
  ): super(LoginInitialState());


  void login(String email, String number, String model) async{
    emit(LoginLoadingState());
    final response = await _loginUseCase(Tuple3(
      email, number, model
    ));

    response.fold(
      (f)=> emit(LoginFailureState(f.message)),
      (success) => emit(LoginSuccessState()) 
    );
  }

}