import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'Note.dart';
//untuk menentukan letak pathnya / databasenya dimana
import 'package:path/path.dart';

class DBHelper {
  Database? _database;

  Future<Database?> get dbInstance async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notesdb.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)");
      },
    );
  }

  //Membuat fungsi getNotes / mengambil notes ketika akan dijalankan dari table
  Future<List<Note>> getNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db!.query('notes');
    return List.generate(
      maps.length,
      (i) {
        return Note(title: maps[i]['title'], body: maps[i]['body']);
      },
    );
  }

  Future<void> saveNote(Note note) async {
    final db = await dbInstance;
    await db!.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
