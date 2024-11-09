import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/shared/data/parsers.dart';

OcassionEntity jsonToOcassionEntity(Map<String, dynamic> json){
  return OcassionEntity(
    json["occasion_id"], 
    json["event"] == null ? null: jsonToEventEntity(json["event"]), 
    json["booking"] == null ? null: jsonToBookingEntity(json["booking"]),
    json["inside"], 
    json["state"]["state_name"],
  );
}