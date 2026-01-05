

import 'package:flutter_crud_demo/modules/todo_objectbox/model.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/repository.dart';

class TodoService {
  final TodoRepository todoRepository;
  TodoService(this.todoRepository);

  Future<List<Todo>> findAll() async {
    return await todoRepository.findAll();
  }

  Future<Todo> find(int id) async {
    return await todoRepository.findById(id);
  }

  Future<Todo> create(String title) async {
    final todo = Todo(title: title, completed: false);
    return await todoRepository.insert(todo);
  }

  Future<Todo> update(int id, String? title, bool? completed) async {
    final todo = await todoRepository.findById(id);
    final newTodo = todo.copyWith(title: title, completed: completed);
    return await todoRepository.update(newTodo);
  }

  Future<bool> delete(int id) async {
    await todoRepository.findById(id);
    return await todoRepository.deleteById(id);
  }
}
