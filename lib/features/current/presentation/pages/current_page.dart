import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/current/presentation/state/current_states.dart';
import 'package:mobile_app/features/current/presentation/widgets/ocassion_tile.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          AppStrings.currentOccasions,
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.bold),
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
                  title: Text(
                    AppStrings.error,
                    style: TextStyle(color: theme.error),
                  ),
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
        child: BlocBuilder<CurrentBloc, CurrentState>(
          builder: (context, state) {
            final provider = context.read<CurrentBloc>();

            if (state is CurrentInitialState) {
              provider.seekOcassions();
            }

            return switch (state) {
              CurrentLoadingState _ => const Center(child: CircularProgressIndicator()),
              CurrentRetrieveFailure _ => _buildMessage(theme, AppStrings.apiError),
              CurrentRetrieveSuccess(ocassions: final ocassions) =>
                  _buildOcassionsList(ocassions, null, provider, theme),
              CurrentLoadingAction(ocassions: final ocassions, loadingOcassionId: final idLoading) =>
                  _buildOcassionsList(ocassions, idLoading, provider, theme),
              CurrentActionFailure(ocassions: final ocassions) =>
                  _buildOcassionsList(ocassions, null, provider, theme),
              CurrentState _ => const Center(child: CircularProgressIndicator()),
            };
          },
        ),
      ),
    );
  }

  Widget _buildOcassionsList(
    List<OcassionEntity> ocassions,
    int? loadingOcassionId,
    CurrentBloc provider,
    ColorScheme theme,
  ) {
    if (ocassions.isEmpty) {
      return _buildMessage(theme, AppStrings.noOcassionsAvailableAtTheMoment);
    }

    return Scrollbar(
      thumbVisibility: true,
      radius: const Radius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: ocassions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: OcassionTile(
                ocassion: ocassions[index],
                callback: (id) => actionOnOcassion(id, provider),
                loadingOcassionId: loadingOcassionId,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessage(ColorScheme theme, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: theme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void actionOnOcassion(int id, CurrentBloc provider) {
    provider.actionOnOcassion(id);
  }
}
