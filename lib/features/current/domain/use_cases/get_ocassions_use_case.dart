import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';

class GetOcassionsUseCase implements UseCase<List<OcassionEntity>, void> {
  final CurrentRepo repo;

  GetOcassionsUseCase(this.repo);

  @override
  Future<Either<Failure, List<OcassionEntity>>> call(void param) async {
    return repo.getOcassions();
  }
}
