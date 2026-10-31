import 'package:flutter/material.dart';

class SqlBasicsScreen extends StatelessWidget {
  const SqlBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Part 1 — SQL Basics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _InfoCard(
            title: 'A table looks like a spreadsheet',
            text: 'Every table has columns (the headings) and rows (the records).',
            sql:
            'students\n'
                'id | name  | age\n'
                '---+-------+----\n'
                ' 1 | Rahim | 20\n'
                ' 2 | Karim | 22',
          ),
          _InfoCard(
            title: 'Data types',
            text:
            'Each column stores one kind of value.\n'
                '• INTEGER  whole numbers (1, 20, 500)\n'
                '• TEXT     words ("Rahim")\n'
                '• REAL     decimals (3.75)\n'
                'SQLite has no true/false type. Use INTEGER: 1 = true, 0 = false.',
            sql: 'age INTEGER,\nname TEXT,\ngpa REAL',
          ),
          _InfoCard(
            title: '1. CREATE TABLE — make a new table',
            text:
            'PRIMARY KEY gives every row its own unique id.\n'
                'AUTOINCREMENT means the database counts 1, 2, 3... for you.\n'
                'NOT NULL means "this column can not be empty".',
            sql:
            'CREATE TABLE students (\n'
                '  id   INTEGER PRIMARY KEY AUTOINCREMENT,\n'
                '  name TEXT NOT NULL,\n'
                '  age  INTEGER NOT NULL\n'
                ');',
          ),
          _InfoCard(
            title: '2. INSERT — add a row',
            text:
            'List the columns, then the values in the same order. '
                'We skip id because AUTOINCREMENT fills it.',
            sql: "INSERT INTO students (name, age)\nVALUES ('Rahim', 20);",
          ),
          _InfoCard(
            title: '3. SELECT — read rows (Part 2)',
            text:
            '* means "all columns". WHERE keeps only the rows that match.',
            sql:
            'SELECT * FROM students;\n\n'
                'SELECT name FROM students\n'
                'WHERE age > 20;',
          ),
          _InfoCard(
            title: '4. UPDATE — change a row (Part 2)',
            text: 'Always use WHERE! Without it, EVERY row is changed.',
            sql: "UPDATE students\nSET age = 21\nWHERE id = 1;",
          ),
          _InfoCard(
            title: '5. DELETE — remove a row (Part 2)',
            text:
            'Always use WHERE here too! Without it, EVERY row is deleted.',
            sql: 'DELETE FROM students\nWHERE id = 1;',
          ),
          _InfoCard(
            title: 'The ? placeholder (important!)',
            text:
            'In Flutter we do NOT glue user text into the SQL string. '
                'We put a ? and pass the value separately. This keeps your '
                'app safe from SQL injection (someone typing SQL as a name).',
            sql:
            "// BAD  (never do this)\n"
                "'INSERT ... VALUES (\"\$name\", \$age)'\n\n"
                "// GOOD\n"
                "db.rawInsert(\n"
                "  'INSERT INTO students (name, age) VALUES (?, ?)',\n"
                "  [name, age],\n"
                ");",
          ),
        ],
      ),
    );
  }
}

// One white card: a title, a few plain words, and a gray code box.
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.text, required this.sql});

  final String title;
  final String text;
  final String sql;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(text, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 10),

            // The gray box that shows the code. SelectableText lets students
            // press and hold to copy it.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                sql,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}