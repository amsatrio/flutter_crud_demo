import 'package:flutter_crud_demo/main.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/repository.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/service.dart';

void getItTodoObjectBox() {
  getIt.registerSingleton<TodoRepository>(TodoRepository());
  getIt.registerLazySingleton<TodoService>(
    () => TodoService(getIt<TodoRepository>())
  );
}