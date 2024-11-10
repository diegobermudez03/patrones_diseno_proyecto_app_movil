import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';

class EventTile extends StatelessWidget {
  final OcassionEntity event;

  EventTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final DateFormat dateFormatter = DateFormat('MMM dd, yyyy'); // Example format

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image (Placeholder - Replace with your image)
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/event_placeholder.png'), // Replace this with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Event name
          Text(
            event.event!.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primary,
            ),
          ),
          const SizedBox(height: 4),
          // Event address
          Text(
            event.event!.address,
            style: TextStyle(
              fontSize: 14,
              color: theme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          // Event date range
          Text(
            '${dateFormatter.format(event.event!.startDate)} - ${dateFormatter.format(event.event!.endDate)}',
            style: TextStyle(
              fontSize: 14,
              color: theme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          // Action button or confirmed text
          event.state == AppStrings.registeredState
              ? _acceptInvitationButton(context, theme)
              : _confirmedText(theme),
        ],
      ),
    );
  }

  Widget _acceptInvitationButton(BuildContext context, ColorScheme theme) {
    final provider = BlocProvider.of<EventsBloc>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => provider.confirmInvitation(event.ocassionId),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.secondary,
          foregroundColor: theme.onSecondary,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          AppStrings.confirmInvitation,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _confirmedText(ColorScheme theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        AppStrings.confirmed,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: theme.onSurfaceVariant,
        ),
      ),
    );
  }
}
