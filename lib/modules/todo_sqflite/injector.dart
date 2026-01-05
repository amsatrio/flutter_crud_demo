import 'package:flutter_crud_demo/main.dart';
import 'package:flutter_crud_demo/modules/todo_sqflite/service.dart';
import 'package:flutter_crud_demo/modules/todo_sqflite/repository.dart';

void getItTodoSqflite() {
  getIt.registerSingleton<TodoRepository>(TodoRepository());
  getIt.registerLazySingleton<TodoService>(
    () => TodoService(getIt<TodoRepository>())
  );
}