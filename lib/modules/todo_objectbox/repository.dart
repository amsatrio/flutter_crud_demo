import 'package:flutter_crud_demo/main.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/model.dart';

class TodoRepository {
Future<List<Todo>> findAll() async {
    final maps = await objectBox.todoBox.getAllAsync();
    return maps;
  }

  // FIND BY ID
  Future<Todo> findById(int id) async {
    Todo? todo = await objectBox.todoBox.getAsync(id);
    return todo ?? (throw Exception("data not found"));
  }

  // CREATE
  Future<Todo> insert(Todo todo) async {
    final id = await objectBox.todoBox.putAsync(todo);
    return todo.copyWith(id: id);
  }

  // UPDATE
  Future<Todo> update(Todo todo) async {
    return await objectBox.todoBox.putAndGetAsync(todo);
  }

  // DELETE
  Future<bool> deleteById(int id) async {
    return await objectBox.todoBox.removeAsync(id);
  }
}
