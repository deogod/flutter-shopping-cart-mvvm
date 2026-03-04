import 'dart:convert';

import '../../../../achitecture.dart';
import 'package:http/http.dart' as http;

class ItemRemoteDataSource implements ItemDataSource {
  @override
  Future<List<Item>> getItems() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ItemMapper().fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
