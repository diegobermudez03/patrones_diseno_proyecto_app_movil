import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/login/presentation/pages/verification_page.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/login_states.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface, // Modern use of surface color for background
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginFailureState(message: String m):
              {
                emailController.clear();
                phoneController.clear();
                showDialog(
                    context: context,
                    builder: (subContext) {
                      return AlertDialog(
                        title: Text(AppStrings.failedAuthentication, style: TextStyle(color: theme.error)),
                        content: Text(m),
                        backgroundColor: theme.surface,
                        titleTextStyle: TextStyle(color: theme.onError, fontWeight: FontWeight.bold),
                      );
                    });
              }
              ;
              break;
            case LoginSuccessState(number: String num):
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => GetIt.instance.get<SubmitCodeBloc>(),
                          child: VerificationPage(
                            phoneNumber: num,
                          ),
                        )));
              }
              ;
              break;
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final provider = BlocProvider.of<LoginBloc>(context);
            return switch (state) {
              LoginLoadingState _ => const Center(child: CircularProgressIndicator()),
              LoginState _ => Padding(
                padding: const EdgeInsets.all(16.0), // Padding for modern look
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      AppStrings.appName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Larger, bold app title
                    ),
                    // Email TextField
                    TextField(
                      onEditingComplete: () => setState(() {}),
                      controller: emailController,
                      autofillHints: const [AppStrings.emailHint],
                      decoration: InputDecoration(
                        labelText: AppStrings.emailHint,
                        filled: true,
                        fillColor: theme.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryContainer),
                        ),
                      ),
                    ),
                    // Phone TextField (Only digits)
                    TextField(
                      onEditingComplete: () => setState(() {}),
                      controller: phoneController,
                      autofillHints: const [AppStrings.phoneHint],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allows only digits
                      decoration: InputDecoration(
                        labelText: AppStrings.phoneHint,
                        filled: true,
                        fillColor: theme.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.secondaryContainer),
                        ),
                      ),
                    ),
                    // Login Button
                    TextButton(
                      onPressed: (emailController.text.isNotEmpty && phoneController.text.isNotEmpty)
                          ? () => callback(provider, emailController.text, phoneController.text)
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: theme.onPrimary,
                      ),
                      child: const Text(AppStrings.login),
                    ),
                  ],
                ),
              )
            };
          },
        ),
      ),
    );
  }

  void callback(LoginBloc provider, String email, String number) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late final String phoneModel = "model";
    /*
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      phoneModel = '${androidInfo.brand} ${androidInfo.product} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      phoneModel = 'Apple ${iosInfo.model} ${iosInfo.name}';
    }*/
    provider.login(email, number, phoneModel);
  }
}
