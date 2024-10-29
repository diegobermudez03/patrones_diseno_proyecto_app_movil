import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';

class CurrentRepoImpl implements CurrentRepo{

  final String uri;
  final String token;

  CurrentRepoImpl(this.token, this.uri);

  @override
  Future<Either<Failure, bool>> actionOnOcassion(int ocassionId) {
    // TODO: implement actionOnOcassion
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OcassionEntity>>> getOcassions() {
    // TODO: implement getOcassions
    throw UnimplementedError();
  }

  
}