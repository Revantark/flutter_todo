import 'package:path/path.dart';
import 'package:todo/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  Future<Database> database;

  Future<void> init() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, content TEXT, isCompleted INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodo(TodoItem item) async {
    final Database db = await database;
    await db.insert('todo', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(String title) async {
    final Database db = await database;
    await db.delete('todo',where: 'title = ?',whereArgs: [title]);
  }

  Future<List<TodoItem>> getTodos() async {
    final Database db = await database;
    final List<Map> todos = await db.query('todo');
    return List.generate(todos.length, (i) {
      return TodoItem(
          content: todos[i]['content'],
          title: todos[i]['title'],
          isCompleted: todos[i]['isCompleted']);
    });
  }

  Future<void> updateTodo(TodoItem item , String title) async {
    final db = await database;
    await db.update('todo', item.toMap(),where: 'title = ?',whereArgs: [title]);

  }

}
