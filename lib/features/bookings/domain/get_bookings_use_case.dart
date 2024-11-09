import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/shared/shared_repo.dart';

class GetBookingsUseCase implements UseCase<List<OcassionEntity>, void>{

  final SharedRepo repo;

  GetBookingsUseCase(this.repo);

  @override
  Future<Either<Failure, List<OcassionEntity>>> call(void param) {
    return repo.getOcassions(false);
  }

}