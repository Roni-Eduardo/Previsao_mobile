import 'package:previsao_mobile/model/previsao.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _dbName = 'cadastro_tarefas.db';
  static const _dbVersion = 1;

  DatabaseProvider._init();
  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = '$databasePath/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE ${Previsao.nome_tabela} (
        ${Previsao.campo_id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Previsao.campo_descricao} TEXT NOT NULL,
        ${Previsao.campo_latitude} REAL,
        ${Previsao.campo_longitude} REAL
      );
      '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar atualizações de esquema, se necessário
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
