import 'dart:async';
import 'dart:convert';

import 'package:partner_dashboard/helper/http_helper.dart';
import 'package:partner_dashboard/services/end_points.dart';
import 'package:partner_dashboard/services/secure_storage.dart';

class ApiService {
  static FutureOr<bool> login({
    required String partnerKey,
    required String email,
    required String password,
  }) async {
    final body = {
      'partnerKey': partnerKey,
      'email': email,
      'password': password,
    };

    try {
      final response = await HttpHelper.sendPostRequest(
        EndPoints.login,
        body: body,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String accessToken = responseData["accessToken"];
        SecureStorageService().storeAccessToken(accessToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
