import 'package:flutter_crud_demo/config/logger.dart';
import 'package:flutter_crud_demo/main.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/model.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'state.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  Future<List<Todo>> build() async {
    final List<Todo> todos = await getIt<TodoService>().findAll();
    return todos.isEmpty ? [] : todos;
  }

  // CREATE
  Future<void> createData(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await getIt<TodoService>().create(title);
      return [...state.value!, response];
    });
  }

  // UPDATE
  Future<void> updateData(int id, String? title, bool? completed) async {
    logger.d('id: $id');
    state = await AsyncValue.guard(() async {
      final response = await getIt<TodoService>().update(id, title, completed);
      return state.value!
          .map(
            (data) => data.id == id
                ? response.copyWith(title: title, completed: completed)
                : response,
          )
          .toList();
    });
  }

  // DELETE
  Future<void> deleteData(int id) async {
    state = await AsyncValue.guard(() async {
      final status = await getIt<TodoService>().delete(id);

      if(status) {
        return Future.error(Exception("failed to delete data"));
      }

      return state.value!.where((mBiodata) => mBiodata.id != id).toList();
    });
  }
}
