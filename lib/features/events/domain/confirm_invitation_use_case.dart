import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';
import 'package:mobile_app/shared/shared_repo.dart';

class ConfirmInvitationUseCase implements UseCase<bool, int>{

  
  final SharedRepo repo;

  ConfirmInvitationUseCase(this.repo);

  @override
  Future<Either<Failure, bool>> call(int param) {
    return repo.confirmOcassion(param);
  }
}