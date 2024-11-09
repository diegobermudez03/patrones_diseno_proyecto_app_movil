import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';

class ConfirmInvitationUseCase implements UseCase<bool, int>{
  @override
  Future<Either<Failure, bool>> call(int param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}