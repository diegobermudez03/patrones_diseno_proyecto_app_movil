import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';
import 'package:mobile_app/features/events/presentation/state/events_state.dart';
import 'package:mobile_app/features/events/presentation/widgets/event_tile.dart';

class EventsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.events,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<EventsBloc, EventsState>(
        listener: (context, state) {
          if(state is EventsRetrievedState){
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
        child: BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
              final provider = BlocProvider.of<EventsBloc>(context);
              if(state is EventsInitialState){
                provider.retrieveEvents();
              }
              return switch(state){
                EventsRetrievingState() => const CircularProgressIndicator(),
                EventsRetrievingFailureState() => const Center(child:Text(AppStrings.apiError)),
                EventsRetrievedState(events: final e) => _printEvents(e),
                EventsState() => const CircularProgressIndicator(),
              };
              
            },),
      ),
    );
  }

  Widget _printEvents(List<OcassionEntity> events){
    return SingleChildScrollView(
      child: Column(
        children: events.map((e)=> EventTile(event: e)).toList(),
      ),
    );
  }
}