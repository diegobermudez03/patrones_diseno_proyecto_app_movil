import 'package:mobile_app/shared/entities/booking_entity.dart';
import 'package:mobile_app/shared/entities/event_entity.dart';

class OcassionEntity{
  final int ocassionId;
  final EventEntity? event;
  final BookingEntity? booking;
  final bool isInside;

  OcassionEntity(this.ocassionId, this.event, this.booking, this.isInside);
}