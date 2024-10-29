import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, bool>> login(Tuple3 param);
  Future<Either<Failure, String>> submitCode(Tuple2 param);
  Future<Either<Failure, bool>> checkSession(String sessionToken);
}
