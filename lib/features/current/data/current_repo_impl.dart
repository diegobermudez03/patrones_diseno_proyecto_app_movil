import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/current/data/parsers.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/features/current/domain/repositories/current_repo.dart';

class CurrentRepoImpl implements CurrentRepo{

  final String uri;
  final String token;

  CurrentRepoImpl(this.token, this.uri);

  @override
  Future<Either<Failure, bool>> actionOnOcassion(int ocassionId) async{
    try{
      final url =  Uri.http(uri,'/actions');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      final response = await http.post(
        url, 
        headers: headers,
        body : jsonEncode({"occasion_id": ocassionId})
      );
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(jsonDecode(response.body)["message"]));
      }
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(body["inside"]);
    }catch(error){
      print(error);
      return Left(APIFailure(AppStrings.errorWithAPI));
    }
  }

  @override
  Future<Either<Failure, List<OcassionEntity>>> getOcassions() async{
    try{
      final url =  Uri.http(uri,'/my_ocassions', {
        'active' : 'true'
      });
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      final response = await http.get(url, headers: headers);
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(response.body));
      }
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final List<OcassionEntity> ocassions = (body["occasions"] as List<dynamic>)
        .map((ocassion)=> jsonToOcassionEntity(ocassion))
        .toList();
      return Right(ocassions);
    }catch(error){
      print(error);
      return Left(APIFailure(AppStrings.errorWithAPI));
    }
  }

  
}