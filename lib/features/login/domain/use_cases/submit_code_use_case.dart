import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/core/use_case.dart';

class SubmitCodeUseCase implements UseCase<String, Tuple2>{
  
  @override
  Future<Either<Failure, String>> call(Tuple2 param) async{
    await Future.delayed(Duration(seconds: 1));
    //return Left(APIFailure("codigo incorrecto"));
    return Right("JH789R8J34RE8TERT");
  }
}