import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/login/domain/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepo{

  final String uri;

  LoginRepoImpl(this.uri);

  @override
  Future<Either<Failure, bool>> checkSession(String sessionToken) async{
    try{
      final url = Uri.parse('$uri/sessions/check/$sessionToken');
      final response = await http.get(url);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(response.body));
      }
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(body["enabled"]);
    }catch(error){
      return Left(APIFailure(AppStrings.errorWithAPI));
    }
  }

  @override
  Future<Either<Failure, bool>> login(Tuple3 param) async{
     try{
      final url = Uri.parse('$uri/auth/login');
      final Map<String, dynamic> body = {
        "email" : param.value1,
        "number": param.value2,
        "phone_model" : param.value3,
      };

      final response = await http.post(
        url, 
        headers: {
          'content-type' : 'application/json'
        },
        body: jsonEncode(body)
      );
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(response.body));
      }
      return const Right(true);
    }catch(error){
      return Left(APIFailure(AppStrings.apiError));
    }
  }

  @override
  Future<Either<Failure, String>> submitCode(Tuple2 param) async{
     try{
      final url = Uri.parse('$uri/auth/submit');
      final Map<String, dynamic> requestBody = {
        "number" : param.value1,
        "code": param.value2,
      };

      final response = await http.post(
        url, 
        headers: {
          'content-type' : 'application/json'
        },
        body: jsonEncode(requestBody)
      );
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(response.body));
      }
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(body["token"]);
    }catch(error){
      return Left(APIFailure(AppStrings.apiError));
    }
  }

  
}