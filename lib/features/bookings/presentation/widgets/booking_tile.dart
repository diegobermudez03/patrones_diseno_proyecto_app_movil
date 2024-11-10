import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class BookingTile extends StatelessWidget {
  final OcassionEntity booking;

  BookingTile({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // Determine booking type for image or icon
    final bool isHouse = booking.booking!.isHouse;
    final String bookingType = isHouse ? AppStrings.house : AppStrings.apartment;
    final String staticImagePath = isHouse
        ? 'assets/images/house_placeholder.jpg'
        : 'assets/images/apartment_placeholder.jpg'; // Replace with your images

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Static background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(staticImagePath),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    theme.surface.withOpacity(0.2),
                    BlendMode.dstATop,
                  ),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          // Content overlay
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booking type and icon row
              Row(
                children: [
                  Icon(
                    isHouse ? Icons.house : Icons.apartment,
                    color: theme.primaryContainer,
                    size: 40,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    bookingType,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Booking address
              Text(
                booking.booking!.address,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.onSurface,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              // Booking date range (formatted using the preferred intl formatter)
              Text(
                '${_formatDate(booking.booking!.entryDate)} - ${_formatDate(booking.booking!.exitDate)}',
                style: TextStyle(
                  fontSize: 18,
                  color: theme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              // Confirmation button or confirmed text
              booking.state == AppStrings.registeredState
                  ? _acceptInvitationButton(context, theme)
                  : _confirmedText(theme),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // You can use your preferred date formatter here (using intl)
    final dateFormatter = DateFormat('MMM dd, yyyy');
    return dateFormatter.format(date);
  }

  Widget _acceptInvitationButton(BuildContext context, ColorScheme theme) {
    final provider = BlocProvider.of<BookingsBloc>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => provider.confirmInvitation(booking.ocassionId),
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
          style: TextStyle(fontWeight: FontWeight.bold),
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
          fontWeight: FontWeight.w900,
          color: theme.onSurfaceVariant,
        ),
      ),
    );
  }
}
