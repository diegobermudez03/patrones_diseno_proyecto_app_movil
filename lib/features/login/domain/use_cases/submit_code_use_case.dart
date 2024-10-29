import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/features/login/domain/repositories/login_repo.dart';

class SubmitCodeUseCase implements UseCase<String, Tuple2> {
  final LoginRepo repo;

  SubmitCodeUseCase(this.repo);

  @override
  Future<Either<Failure, String>> call(Tuple2 param) async {
    return repo.submitCode(param);
  }
}
