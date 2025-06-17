import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/domain/domain.dart';
import 'package:river_app/presentation/providers/todos_provider/todos_provider.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de invitados')),
      body: const _TodosView(),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(todosProvider.notifier).addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodosView extends ConsumerWidget {
  const _TodosView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final TodoEntity todo = todos[index];

        return SwitchListTile(
          title: Text(todo.description),
          value: todo.done, // True o False
          onChanged: (value) =>
              ref.read(todosProvider.notifier).changeTodoState(todo),
        );
      },
    );
  }
}
