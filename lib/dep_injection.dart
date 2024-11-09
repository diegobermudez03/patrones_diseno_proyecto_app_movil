import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/bookings/domain/get_bookings_use_case.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:mobile_app/features/current/data/current_repo_impl.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';
import 'package:mobile_app/features/current/domain/use_cases/action_on_ocassion_use_case.dart';
import 'package:mobile_app/features/current/domain/use_cases/get_ocassions_use_case.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/events/domain/confirm_invitation_use_case.dart';
import 'package:mobile_app/features/events/domain/get_events_use_case.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';
import 'package:mobile_app/features/login/data/login_repo_impl.dart';
import 'package:mobile_app/features/login/domain/repositories/login_repo.dart';
import 'package:mobile_app/features/login/domain/use_cases/check_session_use_case.dart';
import 'package:mobile_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:mobile_app/features/login/domain/use_cases/submit_code_use_case.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_bloc.dart';
import 'package:mobile_app/shared/data/shared_repo_impl.dart';
import 'package:mobile_app/shared/shared_repo.dart';
import 'package:mobile_app/shared/storage_service/storage_service.dart';

final inst = GetIt.instance;
//const uri = "http://10.0.2.2:3000"; //to use from emulator
const uri = "http://localhost:3000";
//const uri = "quickpass.downloadablefox.dev";

Future<void> initLoginDependencies(StorageService storageService) async {
  //REPOSITORIES
  inst.registerLazySingleton<LoginRepo>(()=>LoginRepoImpl(uri));

  //USE CASES
  inst.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
    inst.get<LoginRepo>()
  ));
  inst.registerLazySingleton<SubmitCodeUseCase>(() => SubmitCodeUseCase(
     inst.get<LoginRepo>()
  ));

  //BLOC
  inst.registerFactory<LoginBloc>(() => LoginBloc(inst.get<LoginUseCase>()));
  inst.registerFactory<SubmitCodeBloc>(
      () => SubmitCodeBloc(inst.get<SubmitCodeUseCase>(), storageService));
}

Future<void> initAllDependencies(String token) async {
  //  CHECK SESSION
  inst.registerLazySingleton<CheckSessionUseCase>(() => CheckSessionUseCase(
     inst.get<LoginRepo>()
  ));


  //  CURRENT PAGE
  //repositories
  inst.registerLazySingleton<CurrentRepo>(()=>CurrentRepoImpl(token, uri));

  //use cases
  inst.registerLazySingleton<GetOcassionsUseCase>(() => GetOcassionsUseCase(
    inst.get<CurrentRepo>()
  ));
  inst.registerLazySingleton<ActionOnOcassionUseCase>(() => ActionOnOcassionUseCase(
    inst.get<CurrentRepo>()
  ));

  //SHARED REPO
  inst.registerLazySingleton<SharedRepo>(()=>SharedRepoImpl(uri, token));

  //EVENTS
  //use cases
  inst.registerLazySingleton<GetEventsUseCase>(()=>GetEventsUseCase(
    inst.get<SharedRepo>()
  ));
  inst.registerLazySingleton<ConfirmInvitationUseCase>(()=>ConfirmInvitationUseCase(
    inst.get<SharedRepo>()
  ));

  //bloc
  inst.registerFactory<CurrentBloc>(() => CurrentBloc(
      inst.get<GetOcassionsUseCase>(), inst.get<ActionOnOcassionUseCase>()));

  inst.registerFactory<EventsBloc>(() => EventsBloc(
    inst.get(),
    inst.get()
  ));


  //bookings
  //use cases
  inst.registerLazySingleton<GetBookingsUseCase>(()=>GetBookingsUseCase(
    inst.get<SharedRepo>()
  ));

  //bloc
  inst.registerFactory<BookingsBloc>(() => BookingsBloc(
      inst.get(),
      inst.get()
  ));
}
