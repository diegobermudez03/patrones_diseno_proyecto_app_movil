import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';

class BookingTile extends StatelessWidget{

  final OcassionEntity booking;

  BookingTile({
    super.key,
    required this.booking
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(booking.booking!.isHouse ? AppStrings.house : AppStrings.apartment),
        Text(booking.booking!.address),
        Text(' ${booking.booking!.entryDate} - ${booking.booking!.exitDate}'),
        if(booking.state == AppStrings.registered) _acceptInvitation(context) else Text(AppStrings.confirmed)
      ],
    );
  }

  TextButton _acceptInvitation(BuildContext context){
    final provider = BlocProvider.of<BookingsBloc>(context);
    return TextButton(
      onPressed: ()=>provider.confirmInvitation(booking.ocassionId), 
      child: const Text(AppStrings.confirmInvitation)
    );
  }
}