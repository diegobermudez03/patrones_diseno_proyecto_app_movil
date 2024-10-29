abstract class CurrentRepo {
  Future<Either<Failure, bool>> actionOnOcassion(int ocassionId);
}
