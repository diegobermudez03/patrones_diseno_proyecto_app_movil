import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:mobile_app/features/bookings/presentation/state/bookings_states.dart';
import 'package:mobile_app/features/bookings/presentation/widgets/booking_tile.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';


class BookingsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.bookings,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<BookingsBloc, BookingsState>(
        listener: (context, state) {
          if(state is BookingsRetrievedState){
            if(state.justConfirmed){
              showDialog(context: context, builder: (subcontext){
                return AlertDialog(
                  content: Text(AppStrings.confirmationMadeSuccesfully),
                );
              });
            }
            if(state.errorConfirming){
              showDialog(context: context, builder: (subcontext){
                return AlertDialog(
                  content: Text(AppStrings.errorDoingConfirmation),
                );
              });
            }
          }
        },
        child: BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
              final provider = BlocProvider.of<BookingsBloc>(context);
              if(state is BookingsInitialState){
                provider.retrieveBookings();
              }
              return switch(state){
                BookingsRetrievingState() => const CircularProgressIndicator(),
                BookingsRetrievingFailureState() => const Center(child:Text(AppStrings.apiError)),
                BookingsRetrievedState(bookings: final b) => _printBookings(b),
                BookingsState() => const CircularProgressIndicator(),
              };
              
            },),
      ),
    );
  }

  Widget _printBookings(List<OcassionEntity> bookings){
    return SingleChildScrollView(
      child: Column(
        children: bookings.map((b)=> BookingTile(booking: b)).toList(),
      ),
    );
  }
}