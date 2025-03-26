import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ahun.sqlite');

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        final data = await rootBundle.load('assets/ahun.sqlite');
        final bytes = data.buffer.asUint8List();
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print('Error copying database: $e');
      }
    }

    return openDatabase(path);
  }

 Future<List<Word>> search(String query) async {
  final db = await database;
  final trimmedQuery = query.trim();
  final data = await db.query(
    "dictionary",
    where: "_id LIKE ? OR AMH LIKE ?",
    whereArgs: ['%$trimmedQuery%', '%$trimmedQuery%'],
  );
  List<Word> tasks = data.map((e) => Word(
    id: e['_id'] as String,
    en: e["EN"] as String,
    amh: e["AMH"] as String,
  )).toList();

  return tasks;
}


  Future<List<Word>> getData() async {
    final db = await database;
    final data = await db.query("dictionary");
    List<Word> tasks = data.map((e) => Word(
      id: e['_id'] as String,
      en: e["EN"] as String,
      amh: e["AMH"] as String,
    )).toList();

    return tasks;
  }
}

class Word {
  String id, en, amh;
  Word({
    required this.id,
    required this.en,
    required this.amh,
  });
}
