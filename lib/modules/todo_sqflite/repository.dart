import 'package:flutter_crud_demo/modules/todo_sqflite/database.dart';
import 'package:flutter_crud_demo/modules/todo_sqflite/model.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepository {
  Database? db;
  Future open() async {
    db ??= await TodoDatabase.instance.database;
  }

  Future close() async {
    await db?.close();
  }

  // FIND ALL
  Future<List<Todo>> findAll() async {
    await open();

    final maps = await db!.query('todos');

    return maps.map((map) => Todo.fromJson(map)).toList();
  }

  // FIND BY ID
  Future<Todo> findById(int id) async {
    await open();

    List<Map<String, dynamic>> maps = await db!.query(
      'todos',
      columns: ['id', 'title', 'completed'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      throw Exception("data not found");
    }

    return Todo.fromJson(maps.first);
  }

  // CREATE
  Future<Todo> insert(Todo todo) async {
    await open();

    final id = await db!.insert('todos', todo.toJson());
    return todo.copyWith(id: id);
  }

  // UPDATE
  Future<Todo> update(Todo todo) async {
    await open();

    int status = await db!.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    if (status == 0) {
      throw Exception("update failed");
    }
    return todo;
  }

  // DELETE
  Future<bool> deleteById(int id) async {
    await open();
    
    int columnAffected = await db!.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    return columnAffected > 0 ? true : false;
  }
}
