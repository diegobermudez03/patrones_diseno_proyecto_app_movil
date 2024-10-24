import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';

class LoginUseCase implements UseCase<bool, Tuple3>{

  @override
  Future<Either<Failure, bool>> call(Tuple3 param) async{
    await Future.delayed(Duration(seconds: 1));
    return Right(true);
    //return Left(APIFailure("errorrrrrrr"));

  }
}