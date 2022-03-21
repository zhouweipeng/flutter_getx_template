part of sqlite;

/// 管理笔记的数据库方法类
class NotesDatabase {
  // 命名构造函数
  NotesDatabase._init();

  // 使用命名构造函数生成单例模式
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    // 第一次先初始化数据库,之后获取直接返回缓存的数据库实例
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      final textType = 'TEXT NOT NULL';
      final boolType = 'BOOLEAN NOT NULL';
      final integerType = 'INTEGER NOT NULL';
      await db.execute('''
        CREATE TABLE $tableNotes ( 
          ${NoteFields.id} $idType, 
          ${NoteFields.isImportant} $boolType,
          ${NoteFields.number} $integerType,
          ${NoteFields.title} $textType,
          ${NoteFields.description} $textType,
          ${NoteFields.time} $textType
        )
      ''');
    });
  }

  // 新增一条数据
  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  // 获取一条数据的详情
  Future<Note> getDetail(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // 获取数据列表
  Future<List<Note>> getList() async {
    final db = await instance.database;
    final orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  // 更新一条数据
  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  // 删除一条数据
  Future<int> remove(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // 关闭数据库
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
