import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';
import 'package:mobile_app/shared/entities/booking_entity.dart';
import 'package:mobile_app/shared/entities/event_entity.dart';

class GetOcassionsUseCase implements UseCase<List<OcassionEntity>, void> {
  final CurrentRepo repo;

  GetOcassionsUseCase(this.repo);

  @override
  Future<Either<Failure, List<OcassionEntity>>> call(void param) async {
    await Future.delayed(Duration(seconds: 1));
    return Right([
      OcassionEntity(
          1,
          EventEntity(
              1, "Comic con", "Calle 7a", DateTime.now(), DateTime.now()),
          null,
          true),
      OcassionEntity(
          2,
          null,
          BookingEntity(1, true, "Carrera 87", DateTime.now(), DateTime.now()),
          true)
    ]);
  }
}
