import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryFixedDim, theme.secondaryFixedDim],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BlocListener<SubmitCodeBloc, SubmitCodeState>(
            listener: (context, state) {
              if (state is SubmitCodeFailure) {
                controller.clear();
                showDialog(
                  context: context,
                  builder: (subContext) => AlertDialog(
                    content: Text(state.message),
                    backgroundColor: theme.errorContainer,
                    contentTextStyle: TextStyle(color: theme.onErrorContainer),
                  ),
                );
              }
              if (state is SubmitCodeSuccess) {
                // Navigate to waiting page
                while (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WaitingPage(),
                  ),
                );
              }
            },
            child: BlocBuilder<SubmitCodeBloc, SubmitCodeState>(
              builder: (context, state) {
                return state is SubmitCodeLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Top section with icon and text
                            _buildVerificationHeader(theme),

                            const SizedBox(height: 24),

                            // TextField for code input
                            _buildCodeInputField(theme),

                            const SizedBox(height: 32),

                            // Submit button
                            _buildSubmitButton(provider, theme),
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

  Widget _buildVerificationHeader(ColorScheme theme) {
    return Column(
      children: [
        // Verification icon with circular background
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [theme.primaryContainer, theme.secondaryContainer],
            ),
          ),
          child: Icon(
            Icons.verified_user,
            size: 64,
            color: theme.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        // Instruction text
        Text(
          AppStrings.enter4digitCode,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.surface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.codeSentToEmail,
          style: TextStyle(
            fontSize: 16,
            color: theme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCodeInputField(ColorScheme theme) {
    return TextField(
      controller: controller,
      maxLength: 4,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counterText: "", // Hide character counter
        hintText: AppStrings.digit4Code,
        hintStyle: TextStyle(color: theme.onSurfaceVariant.withOpacity(0.7)),
        filled: true,
        fillColor: theme.surfaceContainer,
        prefixIcon: Icon(Icons.security, color: theme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primary, width: 2),
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24, color: theme.onSurface),
    );
  }

  Widget _buildSubmitButton(SubmitCodeBloc provider, ColorScheme theme) {
    return ElevatedButton(
      onPressed: () => buttonCallback(provider, controller.text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: theme.secondary,
        elevation: 4,
      ),
      child: Text(
        AppStrings.submit,
        style: TextStyle(
          fontSize: 18,
          color: theme.onSecondary,
        ),
      ),
    );
  }

  void buttonCallback(SubmitCodeBloc provider, String code) {
    provider.submit(phoneNumber, code);
  }
}
