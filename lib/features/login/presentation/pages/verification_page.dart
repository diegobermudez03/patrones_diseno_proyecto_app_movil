import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatting
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/login/presentation/pages/waiting_page.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_states.dart';

class VerificationPage extends StatelessWidget {
  final controller = TextEditingController();
  final String phoneNumber;

  VerificationPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SubmitCodeBloc>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: BlocListener<SubmitCodeBloc, SubmitCodeState>(
        listener: (context, state) {
          if (state is SubmitCodeFailure) {
            controller.clear();
            showDialog(
                context: context,
                builder: (subContext) {
                  return AlertDialog(
                    content: Text(state.message),
                    backgroundColor: theme.errorContainer,
                    contentTextStyle: TextStyle(color: theme.onErrorContainer),
                  );
                });
          }
          if (state is SubmitCodeSuccess) {
            while (Navigator.of(context).canPop()) Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  WaitingPage(),
                )
            );
          }
        },
        child: BlocBuilder<SubmitCodeBloc, SubmitCodeState>(
          builder: (context, state) {
            return switch (state) {
              SubmitCodeLoadingState _ => const Center(child: CircularProgressIndicator()),
              SubmitCodeState _ => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Verification Icon and text
                    Icon(Icons.verified, color: theme.primary, size: 48), // Added a verification icon
                    const Text(
                      AppStrings.enter4digitCode,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      AppStrings.codeSentToEmail,
                      style: TextStyle(fontSize: 16),
                    ),

                    // TextField for verification code
                    TextField(
                      controller: controller,
                      maxLength: 4, // Limit input to 4 digits
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Accept only digits
                      decoration: InputDecoration(
                        labelText: AppStrings.digit4Code, 
                        labelStyle: TextStyle(color: theme.onSurface),
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

                    // Submit button
                    TextButton(
                      onPressed: () => buttonCallback(provider, controller.text),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: theme.onSecondary,
                      ),
                      child: const Text(AppStrings.submit), 
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

  void buttonCallback(SubmitCodeBloc provider, String code) {
    provider.submit(phoneNumber, code);
  }
}
