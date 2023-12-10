import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_dhani/data/datasources/local/auth_local_datasource.dart';
import 'package:flutter_cbt_dhani/data/models/responses/ujian_response_model.dart';
import 'package:http/http.dart' as http;

class UjianRemoteDatasouce {
  Future<Either<String, UjianResponseModel>> getUjianByKategori(
      String kategori) async {
    final authData = await AuthLocalDatasource().getAuth();
    final response = await http.get(
        Uri.parse(
            'https://fic10.rrdhani.my.id/api/get-soal-ujian?kategori=$kategori'),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer ${authData.accessToken}'
        });
    if (response.statusCode == 200) {
      return Right(UjianResponseModel.fromJson(response.body));
    } else {
      return const Left('get ujian by kategori gagal');
    }
  }

  Future<Either<String, String>> createUjian() async {
    final authData = await AuthLocalDatasource().getAuth();
    final response = await http.post(
      Uri.parse('https://fic10.rrdhani.my.id/api/create-ujian'),
      headers: {
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      return const Right('create ujian berhasil');
    } else {
      return const Left('create ujian gagal');
    }
  }
}
