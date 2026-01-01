import 'dart:convert';

import 'package:flutter_crud_demo/modules/todo/model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'service.g.dart';

@riverpod
class TodoList extends _$TodoList {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  @override
  Future<List<Todo>> build() async {
    final response = await http.get(Uri.parse('$_baseUrl?_limit=10'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Todo.fromJson(json)).toList();
  }

  // CREATE
  Future<void> addTodo(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: jsonEncode({'title': title, 'completed': false, 'userId': 1}),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      final newTodo = Todo.fromJson(jsonDecode(response.body));
      return [...state.value!, newTodo];
    });
  }

  // UPDATE
  Future<void> editTodo(int id, String title) async {
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.parse('$_baseUrl/$id'),
        body: jsonEncode({'title': title}),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      return state.value!.map((todo) => todo.id == id ? todo.copyWith(title: title) : todo).toList();
    });
  }

  // TOGGLE STATUS
  Future<void> toggle(int id) async {
    final todo = state.value!.firstWhere((t) => t.id == id);
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.parse('$_baseUrl/$id'),
        body: jsonEncode({'completed': !todo.completed}),
      );
      return state.value!.map((t) => t.id == id ? t.copyWith(completed: !t.completed) : t).toList();
    });
  }

  // DELETE
  Future<void> removeTodo(int id) async {
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.parse('$_baseUrl/$id'));
      return state.value!.where((todo) => todo.id != id).toList();
    });
  }
}

