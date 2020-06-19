import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mntd_mobile/models/secret_model.dart';
import 'package:mntd_mobile/utils/constants.dart';

class SecretsService {

  final String allSecretsUrl = "$BASE_URL/secrets";

  Future<List<Secret>> getSecrets(String username) async {
    var res = await http.get("$allSecretsUrl/$username");

    if (res.statusCode == 200) {
      var jsonResponse = jsonDecode(res.body);
      List<dynamic> data = jsonResponse['data'];
      List<Secret> secrets =
          data.map((dynamic item) => Secret.fromJson(item)).toList();
      return secrets;
    } else {
      throw 'Can`t get secrets';
    }
  }
}
