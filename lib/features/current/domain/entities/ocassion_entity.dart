import 'package:mobile_app/shared/entities/booking_entity.dart';
import 'package:mobile_app/shared/entities/event_entity.dart';

class OcassionEntity{
  final int ocassionId;
  final EventEntity? event;
  final BookingEntity? booking;
  bool isInside;
  String state;

  OcassionEntity(this.ocassionId, this.event, this.booking, this.isInside, this.state);
}