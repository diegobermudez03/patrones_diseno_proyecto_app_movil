import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

abstract class BookingsState{}

class BookingsInitialState implements BookingsState{}

class BookingsRetrievingState implements BookingsState{}

class BookingsRetrievedState implements BookingsState{
  final List<OcassionEntity> bookings;
  final bool justConfirmed;
  final bool errorConfirming;

  BookingsRetrievedState(this.bookings, this.justConfirmed, this.errorConfirming);
}

class BookingsRetrievingFailureState implements BookingsState{}