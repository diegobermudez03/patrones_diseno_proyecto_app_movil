import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/core/color_theme.dart';
import 'package:mobile_app/dep_injection.dart';
import 'package:mobile_app/features/current/pages/current_page.dart';
import 'package:mobile_app/features/login/presentation/pages/login_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  
  final String? token = await readToken();
  late bool loginPage;
  if(token == null){
    await initLoginDependencies();
    loginPage = true;
  }else{
    await initAllDependencies(token);
    loginPage = false;
  }
  initLoginDependencies();
  runApp(MyApp(loginPage: loginPage));
}

class MyApp extends StatelessWidget {
  final bool loginPage;

  const MyApp({
    super.key,
    required this.loginPage
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: MaterialTheme.darkMediumContrastScheme(),
        useMaterial3: true,
      ),
      home: loginPage ? LoginPage() : CurrentPage(),
    );
  }
}


Future<String?> readToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'auth_token');
}