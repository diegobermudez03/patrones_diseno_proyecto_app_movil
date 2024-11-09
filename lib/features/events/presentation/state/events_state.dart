import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

abstract class EventsState{}

class EventsInitialState implements EventsState{}

class EventsRetrievingState implements EventsState{}

class EventsRetrievedState implements EventsState{
  final List<OcassionEntity> events;
  final bool justConfirmed;
  final bool errorConfirming;

  EventsRetrievedState(this.events, this.justConfirmed, this.errorConfirming);
}

class EventsRetrievingFailureState implements EventsState{}