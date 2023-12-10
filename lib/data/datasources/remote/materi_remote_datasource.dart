import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_dhani/data/models/responses/materi_response_model.dart';
import 'package:http/http.dart' as http;

import '../local/auth_local_datasource.dart';

class MateriRemoteDatasource {
  Future<Either<String, MateriResponseModel>> getAllMateri() async {
    final authData = await AuthLocalDatasource().getAuth();
    final response = await http
        .get(Uri.parse('https://fic10.rrdhani.my.id/api/materis'), headers: {
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer ${authData.accessToken}',
    });
    if (response.statusCode == 200) {
      return right(MateriResponseModel.fromJson(response.body));
    } else {
      return left('materi gagal');
    }
  }
}
