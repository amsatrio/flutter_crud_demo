import 'package:flutter/material.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/model.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void _showTodoDialog(BuildContext context, WidgetRef ref, {Todo? todo}) {
  final controller = TextEditingController(text: todo?.title ?? '');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(todo == null ? 'Add Task' : 'Edit Task'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Todo Title'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = controller.text.trim();
            if (title.isNotEmpty) {
              if (todo == null) {
                ref.read(todoStateProvider.notifier).createData(title);
              } else {
                ref.read(todoStateProvider.notifier).updateData(todo.id!, title, null);
              }
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod CRUD')),
      body: todoList.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              title: Text(todo.title),
              onTap: () => _showTodoDialog(context, ref, todo: todo),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (_) => ref.read(todoStateProvider.notifier).updateData(todo.id!, null, todo.completed ? false : true),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => ref.read(todoStateProvider.notifier).deleteData(todo.id!),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}