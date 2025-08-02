import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../services/api_service.dart';

class CryptoProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Crypto> _cryptoList = [];
  bool _isLoading = false;

  List<Crypto> get cryptoList => _cryptoList;
  bool get isLoading => _isLoading;

  Future<void> loadCrypto() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cryptoList = await _apiService.fetchCryptoList();
    } catch (e) {
      print('Error fetching data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
