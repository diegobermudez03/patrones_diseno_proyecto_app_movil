abstract class Failure{
  String get message;
}

class APIFailure implements Failure{
  @override
  String message;
  APIFailure(this.message);
}