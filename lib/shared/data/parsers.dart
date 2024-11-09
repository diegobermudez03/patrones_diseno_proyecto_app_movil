import 'package:mobile_app/shared/entities/booking_entity.dart';
import 'package:mobile_app/shared/entities/event_entity.dart';

BookingEntity jsonToBookingEntity(Map<String, dynamic> json){
  return BookingEntity(
    json["booking_id"], 
    json["accomodation"]["is_house"],
    json["accomodation"]["address"], 
    DateTime.parse(json["entry_date"]),
    DateTime.parse(json["exit_date"]),
  );
}

EventEntity jsonToEventEntity(Map<String, dynamic> json){
  return EventEntity(
    json["event_id"],
    json["name"],
    json["address"],
    DateTime.parse(json["start_date"]),
    DateTime.parse(json["end_date"])
  );
}
