import 'package:flutter_cbt_dhani/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuth(AuthResponseModel model) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('auth_data', model.toJson());
  }

  Future<void> removeAuth() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('auth_data');
  }

  Future<AuthResponseModel> getAuth() async {
    final pref = await SharedPreferences.getInstance();
    final authData = pref.getString('auth_data');
    return AuthResponseModel.fromJson(authData!);
  }
}
