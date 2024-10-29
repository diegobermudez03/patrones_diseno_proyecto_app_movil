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
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          AppStrings.currentOccasions,
          style: TextStyle(color: theme.onPrimary),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<CurrentBloc, CurrentState>(
        listener: (context, state) {
          if (state is CurrentActionFailure) {
            showDialog(
              context: context,
              builder: (subContext) {
                return AlertDialog(
                  title: Text(AppStrings.error, style: TextStyle(color: theme.error)),
                  content: Text(
                    state.message,
                    style: TextStyle(color: theme.onErrorContainer),
                  ),
                  backgroundColor: theme.errorContainer,
                );
              },
            );
          }
        },
        child: BlocBuilder<CurrentBloc, CurrentState>(builder: (context, state) {
          final provider = BlocProvider.of<CurrentBloc>(context);

          if (state is CurrentInitialState) {
            provider.seekOcassions();
          }

          return switch (state) {
            CurrentLoadingState _ => const Center(child: CircularProgressIndicator()),
            CurrentRetrieveFailure _ => Center(
              child: Text(
                AppStrings.apiError,
                style: TextStyle(color: theme.onSurfaceVariant),
              ),
            ),
            CurrentRetrieveSuccess(ocassions: final ocassions) =>
                _printOcassions(ocassions, null, provider),
            CurrentLoadingAction(ocassions: final ocassions, loadingOcassionId: final idLoading) =>
                _printOcassions(ocassions, idLoading, provider),
            CurrentActionFailure(ocassions: final ocassions) =>
                _printOcassions(ocassions, null, provider),
            CurrentState _ => const Center(child: CircularProgressIndicator()),
          };
        }),
      ),
    );
  }

  Widget _printOcassions(List<OcassionEntity> ocassions, int? loadingOcassionId, CurrentBloc provider) {
    return Scrollbar(
      thumbVisibility: true,
      radius: const Radius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: ocassions
                .map((oc) => OcassionTile(
                      ocassion: oc,
                      callback: (id) => actionOnOcassion(id, provider),
                      loadingOcassionId: loadingOcassionId,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void actionOnOcassion(int id, CurrentBloc provider) {
    provider.actionOnOcassion(id);
  }
}
