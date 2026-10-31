import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateInsertScreen extends StatefulWidget {
  const CreateInsertScreen({super.key});

  @override
  State<CreateInsertScreen> createState() => _CreateInsertScreenState();
}

class _CreateInsertScreenState extends State<CreateInsertScreen> {
  Database? _db;

  final List<String> _log = ['Tap "1. Open database, to begin'];
  void _say(String message) {
    setState(() {
      _log.add(message);
    });
  }

  //openDatabase
  Future<void> OpenDB() async {
    // aikhane jai location path ta pabo ta holo string
    //exm:/data/user/0/com.example.app/databases
    final String dbpath = await getDatabasesPath();
    final String path = join(dbpath, 'student.db');
    //in future if you change table design you increase the version to 2
    // openDatabase() আমাদের একটি Database Object ফেরত দেয়।
    // সেই Database Object রাখার জন্য Database Type ব্যবহার করেছি।
    final Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
         CREATE TABLE students(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         name TEXT ,
         age INTEGER
         
         )
         ''');
      },
    );
    _db = db;
    _say('Database opened at $path, Table ');
    // ShowRows();
    print(path);
  }

  //insert data
  Future<void> InsertInSql() async {}
  // get data
  Future<void> ShowRows() async {
    final Database? db = _db;
    if (db == null) return;

    final List<Map<String, Object?>> rows = await db.query('students');
    _say('Rows in table: $rows');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create insert')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                setState(() {
                  OpenDB;
                });
              },
              child: const Text('1. Open database'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: InsertInSql,
              child: const Text('2. Insert data'),
            ),
            ..._log.map((e) => Text(e)),
            const SizedBox(height: 20),
            const Text(
              'Table rows:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ..._log.map((e) => Text(e)),
          ],
        ),
      ),
    );
  }
}
