import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mntd_mobile/models/secret_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecretCardProvider with ChangeNotifier {
  List<Secret> secretsCards = [];

  UnmodifiableListView<Secret> get allSecrets =>
      UnmodifiableListView(secretsCards);
  initialState() {
    syncDataWithProvider();
  }

  addSecret(Secret _secret) {
    secretsCards.add(_secret);

    updateSharePreferences();
    notifyListeners();
  }

  removeSecret(Secret _secret) {
    secretsCards.removeWhere((secret) => secret.name == _secret.name);
    updateSharePreferences();
    notifyListeners();
  }

  int getSecretsdLength() {
    return secretsCards.length;
  }

  Future updateSharePreferences() async {
    List<String> mySecrets =
        secretsCards.map((e) => json.encode(e.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('secrets', mySecrets);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('secrets');

    if (result != null) {
      secretsCards =
          result.map((e) => Secret.fromJson(json.decode(e))).toList();
    }
    notifyListeners();
  }
}
