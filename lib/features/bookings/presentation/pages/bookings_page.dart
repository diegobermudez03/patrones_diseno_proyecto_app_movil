import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_states.dart';
import 'package:mobile_app/features/bookings/presentation/widgets/booking_tile.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.bookings,
          style: TextStyle(color: theme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primary,
      ),
      body: BlocListener<BookingsBloc, BookingsState>(
        listener: (context, state) {
          if (state is BookingsRetrievedState) {
            if (state.justConfirmed) {
              showDialog(
                context: context,
                builder: (subcontext) => AlertDialog(
                  content: Text(
                    AppStrings.confirmationMadeSuccesfully,
                    style: TextStyle(color: theme.onSurface),
                  ),
                  backgroundColor: theme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
          }
        },
        child: BlocBuilder<BookingsBloc, BookingsState>(
          builder: (context, state) {
            final provider = context.read<BookingsBloc>();
            if (state is BookingsInitialState) {
              provider.retrieveBookings();
            }

            return switch (state) {
              BookingsRetrievingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              BookingsRetrievingFailureState() => _buildErrorMessage(theme),
              BookingsRetrievedState(bookings: final bookings) =>
                  _buildBookingsList(bookings),
              BookingsState() => const Center(child: CircularProgressIndicator()),
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

  Widget _buildBookingsList(List<OcassionEntity> bookings) {
    if (bookings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No bookings available at the moment.',
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
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BookingTile(booking: bookings[index]),
            );
          },
        ),
      ),
    );
  }
}
