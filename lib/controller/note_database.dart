import 'package:note_application/model/constants.dart';
import 'package:note_application/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._singleton();
  NoteDatabase._singleton();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createDatabase();
      return _database!;
    }
  }

  Future<Database> createDatabase() async {
    String fullPath = join(await getDatabasesPath(), 'NotesDatabase.db');
    return await openDatabase(fullPath, version: 1, onCreate: createDB);
  }

  Future<void> createDB(Database database, int i) async {
    await database.execute('''
                          CREATE TABLE $tableName (
                                                 $columnId $idType,
                                                 $columnTitle $textType,
                                                 $columnDateTime $dateType,
                                                 $columnContent $textType
                                              )
                    ''');
  }

  //CRUD
  //Create
  Future<void> createNote(Note note) async {
    final db = await instance.database;
    await db.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Update
  Future<void> updateNote(Note note) async {
    final db = await instance.database;
    await db
        .update(tableName, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  //Get All Notes
  Future<List<Note>> getNotes() async {
    final db = await instance.database;
    List<Map<String, Object?>> listNotes = await db.query(tableName);
    return listNotes.isNotEmpty
        ? listNotes.map((e) => Note.fromMap(e)).toList()
        : [];
  }

  //Get One Note
  Future<Note> getNote(int id) async {
    final db = await instance.database;
    List<Map<String, Object?>> listNotes =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return listNotes.isNotEmpty
        ? listNotes.map((e) => Note.fromMap(e)).first
        : throw Exception('Id: $id Not Found');
  }

  //Delete Note
  Future<void> deleteNote(int id) async {
    final db = await instance.database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
