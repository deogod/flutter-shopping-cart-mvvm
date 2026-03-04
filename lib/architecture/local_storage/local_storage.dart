// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  Future<void> saveData(StorageKey key, Map<String, dynamic> value) async {
    await prefs.setString(key.name, jsonEncode(value));
  }

  Future<void> saveDataList(
      StorageKey key, List<Map<String, dynamic>> value) async {
    await prefs.setString(
      key.name,
      jsonEncode(value),
    );
  }

  Future<Map<String, dynamic>?> getData(StorageKey key) async {
    final jsonString = prefs.getString(key.name);
    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  Future<List<Map<String, dynamic>>?> getDataList(StorageKey key) async {
    final jsonString = prefs.getString(key.name);
    if (jsonString == null) return null;

    final decoded = jsonDecode(jsonString) as List;

    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}

enum StorageKey {
  PEDIDO,
  USER,
  CART,
}
