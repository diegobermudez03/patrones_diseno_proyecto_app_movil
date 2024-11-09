import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart'  as http;
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/core/failures.dart';
import 'package:mobile_app/features/current/data/parsers.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';
import 'package:mobile_app/shared/shared_repo.dart';

class SharedRepoImpl implements SharedRepo{

  final String uri;
  final String token;

  SharedRepoImpl(this.uri, this.token);

  @override
  Future<Either<Failure, bool>> confirmOcassion(int ocassionId) async{
    try{
      final url = Uri.parse('$uri/my_ocassions/$ocassionId');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode({
          "confirming": true
        })
      );
      if(response.statusCode < 200 || response.statusCode >= 300){
        return Left(APIFailure(response.body));
      }
      return const Right(true);
    }catch(error){
      print(error);
      return Left(APIFailure(AppStrings.errorWithAPI));
    }
  }

  @override
  Future<Either<Failure, List<OcassionEntity>>> getOcassions(bool events) async{
     try{
      final url =  events ? Uri.parse('$uri/my_events'): Uri.parse('$uri/my_bookings');
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