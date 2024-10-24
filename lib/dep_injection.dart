
import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';

final inst = GetIt.instance;
const uri = "localhost:3000";

Future<void> initLoginDependencies() async{

  //USE CASES
  inst.registerLazySingleton<LoginUseCase>(()=>LoginUseCase());

  //BLOC
  inst.registerFactory<LoginBloc>(()=> LoginBloc(
    inst.get<LoginUseCase>()
  ));
}

Future<void> initAllDependencies(String token) async{
}