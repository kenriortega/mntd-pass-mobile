import 'dart:convert';

import 'package:http/http.dart';
import 'package:mntd_mobile/models/secret_model.dart';
import 'package:mntd_mobile/utils/constants.dart';

class SecretsService {
  final String allSecretsUrl = "$BASE_URL/secrets";

  Future<List<Secret>> getSecrets() async {
    Response res = await get(allSecretsUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Secret> secrets =
          body.map((dynamic item) => Secret.fromJson(item)).toList();
      return secrets;
    } else {
      throw 'Can`t get secrets';
    }
  }
}
