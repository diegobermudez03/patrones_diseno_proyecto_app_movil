
import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/current/domain/use_cases/get_ocassions_use_case.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/login/domain/check_session_use_case.dart';
import 'package:mobile_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:mobile_app/features/login/domain/use_cases/submit_code_use_case.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_bloc.dart';
import 'package:mobile_app/shared/storage_service/storage_service.dart';

final inst = GetIt.instance;
const uri = "localhost:3000";

Future<void> initLoginDependencies(StorageService storageService) async{

  //USE CASES
  inst.registerLazySingleton<LoginUseCase>(()=>LoginUseCase());
  inst.registerLazySingleton<SubmitCodeUseCase>(()=>SubmitCodeUseCase());

  //BLOC
  inst.registerFactory<LoginBloc>(()=> LoginBloc(
    inst.get<LoginUseCase>()
  ));
  inst.registerFactory<SubmitCodeBloc>(()=> SubmitCodeBloc(
    inst.get<SubmitCodeUseCase>(),
    storageService
  ));
}

Future<void> initAllDependencies(String token) async{

  //  CHECK SESSION
  inst.registerLazySingleton<CheckSessionUseCase>(()=> CheckSessionUseCase());
  
  //  CURRENT PAGE

  //use cases
  inst.registerLazySingleton<GetOcassionsUseCase>(()=> GetOcassionsUseCase());

  //bloc
  inst.registerFactory<CurrentBloc>(()=>CurrentBloc(
    inst.get<GetOcassionsUseCase>()
  ));
}