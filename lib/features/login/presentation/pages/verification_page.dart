import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/presentation/pages/current_page.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/login_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_bloc.dart';
import 'package:mobile_app/features/login/presentation/state/submit_code_states.dart';

class VerificationPage extends StatelessWidget {
  final controller = TextEditingController();
  final String phoneNumber;

  VerificationPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SubmitCodeBloc>(context);
    return Scaffold(
      body: BlocListener<SubmitCodeBloc, SubmitCodeState>(
        listener: (context, state) {
          if(state is SubmitCodeFailure){
            controller.clear();
            showDialog(context: context, builder: 
              (subContext){
                return AlertDialog(
                  content: Text(state.message),
                );
              }
            );
          }
          if(state is SubmitCodeSuccess){
            while( Navigator.of(context).canPop()) Navigator.of(context).pop();
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context)=> BlocProvider(
                  create: (context)=>GetIt.instance.get<CurrentBloc>(),
                  child: CurrentPage(),
                )
              )
            );
          }
        },
        child: BlocBuilder<SubmitCodeBloc, SubmitCodeState>(
          builder: (context, state) {
            return switch (state){
              SubmitCodeLoadingState _ => const Center(child: CircularProgressIndicator()),
              SubmitCodeState _ => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(AppStrings.checkYourEmailForVerificationCode),
                  TextField(
                    //only 4 digits should be available
                    controller: controller,
                  ),
                  TextButton(onPressed: () => buttonCallback(provider, controller.text), child: const Text(AppStrings.submit))
                ],
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
