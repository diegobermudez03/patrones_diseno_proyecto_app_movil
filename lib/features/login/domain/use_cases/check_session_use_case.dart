import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/login/domain/repositories/login_repo.dart';

class CheckSessionUseCase implements UseCase<bool, String> {
  final LoginRepo repo;

  CheckSessionUseCase(this.repo);

  @override
  Future<Either<Failure, bool>> call(String param) async {
    return repo.checkSession(param);
  }
}
