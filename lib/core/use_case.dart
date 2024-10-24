import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';

abstract class UseCase<T,R>{

  Future<Either<Failure, T>> call(R param);
}