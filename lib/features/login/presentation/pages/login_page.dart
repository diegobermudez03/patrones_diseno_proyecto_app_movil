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
  const LoginPage({super.key});

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
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryContainer, theme.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailureState) {
                emailController.clear();
                phoneController.clear();
                showDialog(
                  context: context,
                  builder: (subContext) => AlertDialog(
                    title: Text(
                      AppStrings.failedAuthentication,
                      style: TextStyle(color: theme.error),
                    ),
                    content: Text(AppStrings.errorAuthenticating),
                    backgroundColor: theme.surface,
                    titleTextStyle: TextStyle(
                      color: theme.onError,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (state is LoginSuccessState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (_) => GetIt.instance.get<SubmitCodeBloc>(),
                    child: VerificationPage(phoneNumber: state.number),
                  ),
                ));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final provider = context.read<LoginBloc>();
                return state is LoginLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo section
                            _buildLogo(theme),

                            const SizedBox(height: 24),

                            // App title
                            Text(
                              AppStrings.appName,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: theme.onPrimaryContainer,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 32),

                            // Email TextField
                            _buildTextField(
                              controller: emailController,
                              hint: AppStrings.emailHint,
                              icon: Icons.email_outlined,
                              theme: theme,
                            ),
                            const SizedBox(height: 16),

                            // Phone TextField
                            _buildTextField(
                              controller: phoneController,
                              hint: AppStrings.phoneHint,
                              icon: Icons.phone_outlined,
                              theme: theme,
                              isNumeric: true,
                            ),

                            const SizedBox(height: 32),

                            // Login Button
                            _buildLoginButton(provider, theme),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(ColorScheme theme) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [theme.primary, theme.primaryContainer],
        ),
      ),
      child: Image.asset('assets/images/logo.png')
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required ColorScheme theme,
    bool isNumeric = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.onSurfaceVariant),
        filled: true,
        fillColor: theme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: TextStyle(color: theme.onSurface),
    );
  }

  Widget _buildLoginButton(LoginBloc provider, ColorScheme theme) {
    return ElevatedButton(
      onPressed: ()=>callback(provider, emailController.text, phoneController.text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: theme.shadow,
      ),
      child: Text(
        AppStrings.login,
        style: TextStyle(
          fontSize: 18,
          color: theme.primary,
        ),
      ),
    );
  }

  void callback(LoginBloc provider, String email, String number) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late final String phoneModel = "aaa";

   /*if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      phoneModel = '${androidInfo.brand} ${androidInfo.product} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      phoneModel = 'Apple ${iosInfo.model} ${iosInfo.name}';
    }*/
    provider.login(email, number, phoneModel);
  }
}
