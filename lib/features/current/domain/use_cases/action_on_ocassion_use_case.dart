import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';

class ActionOnOcassionUseCase implements UseCase<bool, int> {
  final CurrentRepo repo;

  ActionOnOcassionUseCase(this.repo);

  @override
  Future<Either<Failure, bool>> call(int param) async {
    return repo.actionOnOcassion(param);
  }
}
