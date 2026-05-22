import 'package:cash_flow/models/charge.dart';
import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/expenditure.dart';
import 'package:cash_flow/models/invite.dart';
import 'package:cash_flow/models/user.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _versao = 2;
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
  ) async {
    if (versaoAntiga < 2) {
      await db.execute('ALTER TABLE usuarios ADD COLUMN senha TEXT NOT NULL DEFAULT ""');
    }
  }

  static const String _sqlCriarUsuarios = '''
    CREATE TABLE usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL,
      senha TEXT NOT NULL
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

  // ==================== CRUD ====================

  // ---- USUÁRIOS ----

  static Future<int> inserirUsuario(String nome, String email, String senha) async {
    final db = await obterBanco();
    return db.insert('usuarios', {'nome': nome, 'email': email, 'senha': senha});
  }

  static Future<User?> obterUsuarioPorEmailESenha(String email, String senha) async {
    final db = await obterBanco();
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  static Future<User?> obterUsuarioPorId(int id) async {
    final db = await obterBanco();
    final result = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  // ---- EVENTOS ----

  static Future<int> inserirEvento(Event event) async {
    final db = await obterBanco();
    final map = Map<String, dynamic>.from(event.toMap());
    map.remove('id');
    return db.insert('eventos', map);
  }

  static Future<void> atualizarEvento(Event event) async {
    final db = await obterBanco();
    await db.update('eventos', event.toMap(), where: 'id = ?', whereArgs: [event.id]);
  }

  static Future<Event?> obterEventoPorId(int id) async {
    final db = await obterBanco();
    final result = await db.query('eventos', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return Event.fromMap(result.first);
  }

  static Future<List<Event>> obterTodosEventos() async {
    final db = await obterBanco();
    final result = await db.query('eventos', orderBy: 'criado_em DESC');
    return result.map((map) => Event.fromMap(map)).toList();
  }

  static Future<int> deletarEvento(int id) async {
    final db = await obterBanco();
    return db.delete('eventos', where: 'id = ?', whereArgs: [id]);
  }

  // ---- PARTICIPANTES ----

  static Future<void> inserirParticipante(int eventoId, int usuarioId) async {
    final db = await obterBanco();
    await db.insert('participantes', {'evento_id': eventoId, 'usuario_id': usuarioId});
  }

  static Future<List<User>> obterParticipantesDoEvento(int eventoId) async {
    final db = await obterBanco();
    final result = await db.rawQuery('''
      SELECT u.* FROM participantes p
      JOIN usuarios u ON u.id = p.usuario_id
      WHERE p.evento_id = ?
    ''', [eventoId]);
    return result.map((map) => User.fromMap(map)).toList();
  }

  static Future<void> removerParticipante(int eventoId, int usuarioId) async {
    final db = await obterBanco();
    await db.delete(
      'participantes',
      where: 'evento_id = ? AND usuario_id = ?',
      whereArgs: [eventoId, usuarioId],
    );
  }

  // ---- DESPESAS ----

  static Future<int> inserirDespesa(Expenditure exp) async {
    final db = await obterBanco();
    final map = Map<String, dynamic>.from(exp.toMap());
    map.remove('id');
    return db.insert('despesas', map);
  }

  static Future<List<Expenditure>> obterDespesasDoEvento(int eventoId) async {
    final db = await obterBanco();
    final result = await db.query(
      'despesas',
      where: 'evento_id = ?',
      whereArgs: [eventoId],
    );
    return result.map((map) => Expenditure.fromMap(map)).toList();
  }

  static Future<int> deletarDespesa(int id) async {
    final db = await obterBanco();
    return db.delete('despesas', where: 'id = ?', whereArgs: [id]);
  }

  // ---- COBRANÇAS ----

  static Future<int> inserirCobranca(Charge charge) async {
    final db = await obterBanco();
    final map = Map<String, dynamic>.from(charge.toMap());
    map.remove('id');
    return db.insert('cobrancas', map);
  }

  static Future<List<Charge>> obterTodasCobrancas() async {
    final db = await obterBanco();
    final result = await db.query('cobrancas', orderBy: 'criado_em DESC');
    return result.map((map) => Charge.fromMap(map)).toList();
  }

  static Future<List<Charge>> obterCobrancasDoEvento(int eventoId) async {
    final db = await obterBanco();
    final result = await db.query(
      'cobrancas',
      where: 'evento_id = ?',
      whereArgs: [eventoId],
    );
    return result.map((map) => Charge.fromMap(map)).toList();
  }

  static Future<void> atualizarCobranca(Charge charge) async {
    final db = await obterBanco();
    await db.update('cobrancas', charge.toMap(), where: 'id = ?', whereArgs: [charge.id]);
  }

  static Future<int> deletarCobranca(int id) async {
    final db = await obterBanco();
    return db.delete('cobrancas', where: 'id = ?', whereArgs: [id]);
  }

  // ---- CONVITES ----

  static Future<int> inserirConvite(Invite invite) async {
    final db = await obterBanco();
    final map = Map<String, dynamic>.from(invite.toMap());
    map.remove('id');
    return db.insert('convites', map);
  }

  static Future<List<Invite>> obterConvitesPorUsuario(int usuarioId) async {
    final db = await obterBanco();
    final result = await db.query(
      'convites',
      where: 'convidado_id = ?',
      whereArgs: [usuarioId],
    );
    return result.map((map) => Invite.fromMap(map)).toList();
  }

  static Future<void> atualizarConvite(Invite invite) async {
    final db = await obterBanco();
    await db.update('convites', invite.toMap(), where: 'id = ?', whereArgs: [invite.id]);
  }
}
