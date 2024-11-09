import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

abstract class SharedRepo{
  Future<Either<Failure,List<OcassionEntity>>> getOcassions(bool events);
  Future<Either<Failure, bool>> confirmOcassion(int ocassionId);
}