import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';
import '../config/constants.dart';

class ApiService {
  Future<List<Crypto>> fetchCryptoList() async {
    final url = Uri.parse('$baseUrl$marketEndpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((item) => Crypto.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load crypto list');
    }
  }
}
