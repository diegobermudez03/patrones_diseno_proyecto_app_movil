import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

abstract class CurrentRepo {
  Future<Either<Failure, bool>> actionOnOcassion(int ocassionId);
  Future<Either<Failure, List<OcassionEntity>>> getOcassions();
}
