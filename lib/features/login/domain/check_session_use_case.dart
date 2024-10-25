import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';

class CheckSessionUseCase implements UseCase<bool, String>{

  @override
  Future<Either<Failure, bool>> call(String param)async {
    await Future.delayed(Duration(seconds: 1));
    return Right(false);
  }
}