import 'package:synergent_task/networking/api_base_helper.dart';

import '../config/api_config.dart';
import '../networking/shared_service.dart';

class LoginController {
  final helper = ApiBaseHelper();

  Future<bool> findDetails(String username, password) async {
    var json = {
      "username": username,
      "password": password,
    };
    final response = await helper.postjson(ApiConfig.baseUrl, json);
    if (response.statusCode == 200) {
      await SharedService.setUserDetails(json);
      return true;
    } else {
      return false;
    }
  }
}
