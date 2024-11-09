import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/events/presentation/state/events_bloc.dart';

class EventTile extends StatelessWidget{

  final OcassionEntity event;

  EventTile({
    super.key,
    required this.event
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(event.event!.name),
        Text(event.event!.address),
        Text(' ${event.event!.startDate} - ${event.event!.endDate}'),
        if(event.state == AppStrings.registered) _acceptInvitation(context) else Text(AppStrings.confirmed)
      ],
    );
  }

  TextButton _acceptInvitation(BuildContext context){
    final provider = BlocProvider.of<EventsBloc>(context);
    return TextButton(
      onPressed: ()=>provider.confirmInvitation(event.ocassionId), 
      child: const Text(AppStrings.confirmInvitation)
    );
  }
}