import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _versao = 1;
  static const String _nomeBanco = 'cash_flow.db';

  static Database? _db;

  static Future<Database> obterBanco() async {
    if (_db != null) return _db!;

    final diretorioBancos = await getDatabasesPath();
    final caminhoBanco = path.join(diretorioBancos, _nomeBanco);

    _db = await openDatabase(
      caminhoBanco,
      version: _versao,
      onCreate: _criarTabelas,
      onUpgrade: _migrarTabelas,
    );

    return _db!;
  }

  static Future<void> _criarTabelas(Database db, int versao) async {
    await db.transaction((txn) async {
      await txn.execute(_sqlCriarUsuarios);
      await txn.execute(_sqlCriarEventos);
      await txn.execute(_sqlCriarParticipantes);
      await txn.execute(_sqlCriarDespesas);
      await txn.execute(_sqlCriarCobrancas);
      await txn.execute(_sqlCriarConvites);
    });
  }

  static Future<void> _migrarTabelas(
    Database db,
    int versaoAntiga,
    int versaoNova,
  ) async {}

  static const String _sqlCriarUsuarios = '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL
    )
  ''';

  static const String _sqlCriarEventos = '''
    CREATE TABLE eventos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT NOT NULL,
      data TEXT NOT NULL,
      status TEXT NOT NULL,
      finalizado_em TEXT,
      cancelado_em TEXT,
      criado_em TEXT
    )
  ''';

  static const String _sqlCriarParticipantes = '''
    CREATE TABLE participantes (
      evento_id INTEGER NOT NULL,
      usuario_id INTEGER NOT NULL,
      PRIMARY KEY (evento_id, usuario_id),
      FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE,
      FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE
    )
  ''';

  static const String _sqlCriarDespesas = '''
    CREATE TABLE despesas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      valor REAL NOT NULL,
      evento_id INTEGER NOT NULL,
      FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE
    )
  ''';

  static const String _sqlCriarCobrancas = '''
    CREATE TABLE cobrancas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      valor REAL NOT NULL,
      de_usuario_id INTEGER NOT NULL,
      para_usuario_id INTEGER NOT NULL,
      evento_id INTEGER NOT NULL,
      criado_em TEXT,
      pago_em TEXT,
      FOREIGN KEY (de_usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
      FOREIGN KEY (para_usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
      FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE
    )
  ''';

  static const String _sqlCriarConvites = '''
    CREATE TABLE convites (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      evento_id INTEGER NOT NULL,
      criador_id INTEGER NOT NULL,
      convidado_id INTEGER NOT NULL,
      status TEXT NOT NULL,
      criado_em TEXT,
      FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE,
      FOREIGN KEY (criador_id) REFERENCES usuarios (id) ON DELETE CASCADE,
      FOREIGN KEY (convidado_id) REFERENCES usuarios (id) ON DELETE CASCADE
    )
  ''';
}
