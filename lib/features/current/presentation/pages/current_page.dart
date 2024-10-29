import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/current/presentation/state/current_states.dart';
import 'package:mobile_app/features/current/presentation/widgets/ocassion_tile.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CurrentBloc, CurrentState>(
        listener: (context, state) {
          if(state is CurrentActionFailure){
            showDialog(
              context: context, 
              builder: (subContext){
                return  AlertDialog(
                  title: Text(AppStrings.error),
                  content: Text(state.message),
                );
              }
            );
          }
        },
        child: BlocBuilder<CurrentBloc, CurrentState>(builder: (context, state) {
          final provider = BlocProvider.of<CurrentBloc>(context);
          if (state is CurrentInitialState) {
            provider.seekOcassions();
          }
          return switch (state) {
            CurrentLoadingState _ => const Center(
                child: CircularProgressIndicator(),
              ),
            CurrentRetrieveFailure _ => const Center(
                child: Text(AppStrings.apiError),
              ),
            CurrentRetrieveSuccess(ocassions: final ocassions) => _printOcassions(ocassions, null, provider),
            CurrentLoadingAction(ocassions: final occasions, loadingOcassionId: final idLoading) => _printOcassions(occasions, idLoading, provider),
            CurrentActionFailure(ocassions: final ocassions) => _printOcassions(ocassions, null, provider),
            CurrentState _ => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        }),
      ),
    );
  }

  SingleChildScrollView _printOcassions(List<OcassionEntity> ocassions, int? loadingOcassionId, CurrentBloc provider){
    return SingleChildScrollView(
                child: Column(
                  children: ocassions
                      .map((oc) => OcassionTile(
                            ocassion: oc,
                            callback: (id) => actionOnOcassion(id, provider),
                            loadingOcassionId: loadingOcassionId,
                          ))
                      .toList(),
                ),
              );
  }

  void actionOnOcassion(int id, CurrentBloc provider) {
    provider.actionOnOcassion(id);
  }

}
