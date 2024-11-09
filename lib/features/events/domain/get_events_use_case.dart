import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class GetEventsUseCase implements UseCase<List<OcassionEntity>, void>{

  @override
  Future<Either<Failure, List<OcassionEntity>>> call(void param) {
    // TODO: implement call
    throw UnimplementedError();
  }

}