import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/login/presentation/pages/verification_page.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/login_states.dart';

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
    return Scaffold(
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
                          title: const Text(AppStrings.failedAuthentication),
                          content: Text(m),
                        );
                      });
                };break;
                case LoginSuccessState _ :{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VerificationPage()));
                };break;
            }

        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final provider = BlocProvider.of<LoginBloc>(context);
            return switch(state){
              LoginLoadingState _ => const Center(child: CircularProgressIndicator()),
              LoginState _ => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    onEditingComplete: () => setState(() {}),
                    controller: emailController,
                    autofillHints: [AppStrings.emailHint],
                  ),
                  TextField(
                    onEditingComplete: () => setState(() {}),
                    controller: phoneController,
                    autofillHints: [AppStrings.emailHint],
                  ),
                  TextButton(
                    onPressed: (emailController.text.isNotEmpty && phoneController.text.isNotEmpty)
                        ? () => callback(provider, emailController.text, phoneController.text)
                        : null,
                    child: const Text(AppStrings.login),
                  ),
                ],
              )
            };
          },
        ),
      ),
    );
  }

  void callback(LoginBloc provider, String email, String number) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late final String phoneModel;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      phoneModel = '${androidInfo.brand} ${androidInfo.product} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      phoneModel = 'Apple ${iosInfo.model} ${iosInfo.name}';
    }
    provider.login(email, number, phoneModel);
  }
}
