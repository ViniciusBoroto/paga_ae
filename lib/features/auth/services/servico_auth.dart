import 'dart:io';

import 'package:cash_flow/core/network/mock_api_client.dart';
import 'package:cash_flow/models/user.dart';
import 'package:flutter/material.dart';

class ServicoAuth extends ChangeNotifier {
  ServicoAuth(this._apiClient);

  final MockApiClient _apiClient;
  bool _autenticado = false;
  User? _currentUser;

  bool get autenticado => _autenticado;
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String senha) async {
    try {
      final response = await _apiClient.post('/auth/login', {
        'email': email,
        'password': senha,
      });
      _currentUser = User.fromJson(response);
      _autenticado = true;
      notifyListeners();
      return true;
    } on HttpException {
      return false;
    }
  }

  Future<void> register(String nome, String email, String senha) async {
    final response = await _apiClient.post('/auth/register', {
      'name': nome,
      'email': email,
      'password': senha,
    });
    _currentUser = User.fromJson(response);
    _autenticado = true;
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    _currentUser = null;
    notifyListeners();
  }
}
