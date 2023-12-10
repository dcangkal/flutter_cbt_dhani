import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_dhani/data/datasources/local/auth_local_datasource.dart';
import 'package:flutter_cbt_dhani/data/models/responses/content_response_model.dart';
import 'package:http/http.dart' as http;

class ContentRemoteDatasource {
  Future<Either<String, ContentResponseModel>> getContentById(String id) async {
    final authData = await AuthLocalDatasource().getAuth();
    final response = await http.get(
        Uri.parse('https://fic10.rrdhani.my.id/api/contents?id=$id'),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer ${authData.accessToken}',
        });
    if (response.statusCode == 200) {
      return right(ContentResponseModel.fromJson(response.body));
    } else {
      return left('content gagal');
    }
  }
}
