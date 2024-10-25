import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/core/color_theme.dart';
import 'package:mobile_app/dep_injection.dart';
import 'package:mobile_app/features/current/presentation/pages/current_page.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/login/domain/check_session_use_case.dart';
import 'package:mobile_app/features/login/presentation/pages/login_page.dart';
import 'package:mobile_app/features/login/presentation/pages/waiting_page.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/shared/homepage/home_page.dart';
import 'package:mobile_app/shared/storage_service/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //getting the storage service here, here we inject the type we want to use
  //and then we passs it to init login dependencies since those are the only ones that need it
  final StorageService storageService = MockStorageService();
  final String? token = await storageService.readToken();

  late bool loginPage;
  bool waitingPage = true;
  if (token == null) {
    await initLoginDependencies(storageService);
    loginPage = true;
  } 
  if(token != null) {
    await initAllDependencies(token);
    loginPage = false;
    final response = await GetIt.instance.get<CheckSessionUseCase>().call(token);
    response.fold(
      (f)=> loginPage = true,
      (s)=> waitingPage = !s, //if token is inactive, it would be false, in which case, waitingPage would be true
    );
  }
  runApp(MyApp(loginPage: loginPage, waitingPage: waitingPage,));
}

class MyApp extends StatelessWidget {
  final bool loginPage;
  final bool waitingPage;

  const MyApp({
    super.key,
    required this.loginPage,
    required this.waitingPage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: MaterialTheme.darkMediumContrastScheme(),
        useMaterial3: true,
      ),
      home: loginPage
          ? BlocProvider(
              create: (context) => GetIt.instance.get<LoginBloc>(),
              child: const LoginPage(),
            )
          : 
          (
            waitingPage ? WaitingPage() : 
            HomePage()
          )
    );
  }
}
