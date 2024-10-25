import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';

class ActionOnOcassionUseCase implements UseCase<bool,int>{
  @override
  Future<Either<Failure, bool>> call(int param) async{
    await Future.delayed(Duration(seconds: 1));

    return Right(false);
  }
}