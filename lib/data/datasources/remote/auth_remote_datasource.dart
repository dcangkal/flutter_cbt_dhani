import "package:dartz/dartz.dart";
import 'package:flutter_cbt_dhani/data/datasources/local/auth_local_datasource.dart';
import "package:flutter_cbt_dhani/data/models/requests/login_request_model.dart";
import "package:flutter_cbt_dhani/data/models/requests/register_request_model.dart";
import "package:flutter_cbt_dhani/data/models/responses/auth_response_model.dart";
import "package:http/http.dart" as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://fic10.rrdhani.my.id/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: model.toJson(),
    );
    if (response.statusCode == 200) {
      return right(
        AuthResponseModel.fromJson(response.body),
      );
    } else {
      return left('register gagal');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://fic10.rrdhani.my.id/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: model.toJson(),
    );
    if (response.statusCode == 200) {
      return right(
        AuthResponseModel.fromJson(response.body),
      );
    } else {
      return left('login gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuth();
    final response = await http.post(
      Uri.parse('https://fic10.rrdhani.my.id/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return right('logout sukses');
    } else {
      return left('logout gagal');
    }
  }
}
