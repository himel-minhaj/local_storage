import 'package:flutter/material.dart';
import 'package:local_storage/part1_sql_basics_setup/basics_screen.dart';
import 'package:local_storage/part1_sql_basics_setup/create_insert_screen.dart';
// import 'package:local_storage/part1_sql_basics_setup/create_insert_screen.dart';
// import 'package:local_storage/part2_crud/crud_playground_screen.dart';
//
// import 'part1_sql_basics_setup/sql_basics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter + SQLite Class')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        children: const [
          _SetupNote(),
          _SectionTitle('Part = SQL Basics & Database Setup'),
          _DemoButton(
            label: 'SQL basics (cheat sheet)',
             screen: SqlBasicsScreen(),
          ),
          _DemoButton(
            label: 'Create Insert Screen',
            screen: CreateInsertScreen(),
          ),
          // _DemoButton(label: 'Crud App', screen: CrudPlaygroundScreen()),
        ],
      ),
    );
  }
}

class _SetupNote extends StatelessWidget {
  const _SetupNote();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'New to databases? Start with Part 1 and go in order. Each part '
              'uses what the one before it taught.\n\n'
              'Run this app on an Android or iOS emulator/phone. sqflite does '
              'not work in Chrome.',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({required this.label, required this.screen});

  final String label;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Align(alignment: Alignment.centerLeft, child: Text(label)),
      ),
    );
  }
}