import 'package:cash_flow/core/utils/database.dart';
import 'package:cash_flow/models/user.dart';
import 'package:flutter/material.dart';

class ServicoAuth extends ChangeNotifier {
  bool _autenticado = false;
  User? _currentUser;

  bool get autenticado => _autenticado;
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String senha) async {
    final user = await DatabaseHelper.obterUsuarioPorEmailESenha(email, senha);
    if (user != null) {
      _currentUser = user;
      _autenticado = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> register(String nome, String email, String senha) async {
    final id = await DatabaseHelper.inserirUsuario(nome, email, senha);
    _currentUser = User(id: id, name: nome, email: email);
    _autenticado = true;
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    _currentUser = null;
    notifyListeners();
  }
}
