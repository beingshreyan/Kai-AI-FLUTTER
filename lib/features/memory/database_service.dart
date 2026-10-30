
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const String _dbName = 'kai_memory.db';
  static const String _tableName = 'chat_history';
  
  
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        isUser INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  
  Future<void> saveMessage({required String text, required bool isUser}) async {
    final db = await instance.database;
    
    await db.insert(
      _tableName,
      {
        'text': text,
        'isUser': isUser ? 1 : 0,
        'timestamp': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  
  Future<List<Map<String, dynamic>>> loadHistory() async {
    final db = await instance.database;
    
    
    final result = await db.query(_tableName, orderBy: 'timestamp ASC');
    
    return result.map((row) => {
      'text': row['text'],
      'isUser': row['isUser'] == 1, 
      'timestamp': row['timestamp'],
    }).toList();
  }

  
  Future<void> wipeMemory() async {
    final db = await instance.database;
    await db.delete(_tableName);
  }
}