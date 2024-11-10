import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';
import 'package:mobile_app/features/events/presentation/state/events_state.dart';
import 'package:mobile_app/features/events/presentation/widgets/event_tile.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.events,
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primary,
      ),
      body: BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {
          if (state is EventsRetrievedState) {
            if (state.justConfirmed) {
              showDialog(
                context: context,
                builder: (subcontext) => AlertDialog(
                  content: Text(
                    AppStrings.confirmationMadeSuccesfully,
                    style: TextStyle(color: theme.onSurface),
                  ),
                  backgroundColor: theme.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            }
            if (state.errorConfirming) {
              showDialog(
                context: context,
                builder: (subcontext) => AlertDialog(
                  content: Text(
                    AppStrings.errorDoingConfirmation,
                    style: TextStyle(color: theme.onErrorContainer),
                  ),
                  backgroundColor: theme.errorContainer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            }
          }
        },
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            final provider = BlocProvider.of<EventsBloc>(context);
            if (state is EventsInitialState) {
              provider.retrieveEvents();
            }

            return switch (state) {
              EventsRetrievingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              EventsRetrievingFailureState() => _buildErrorMessage(theme),
              EventsRetrievedState(events: final events) => _buildEventsList(events),
              EventsState() => const Center(child: CircularProgressIndicator()),
            };
          },
        ),
      ),
    );
  }

  Widget _buildErrorMessage(ColorScheme theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          AppStrings.apiError,
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

  Widget _buildEventsList(List<OcassionEntity> events) {
    if (events.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            AppStrings.noEventsAvailableAtTheMoment,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Scrollbar(
      thumbVisibility: true,
      radius: const Radius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: EventTile(event: events[index]),
            );
          },
        ),
      ),
    );
  }
}
