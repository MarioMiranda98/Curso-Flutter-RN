import 'package:river_app/config/config.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:river_app/domain/entities/todo_entity.dart';

const _uuid = Uuid();

final todosProvider = StateNotifierProvider<TodosNotifier, List<TodoEntity>>((
  ref,
) {
  return TodosNotifier();
});

class TodosNotifier extends StateNotifier<List<TodoEntity>> {
  TodosNotifier()
    : super([
        TodoEntity(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null,
        ),
        TodoEntity(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null,
        ),
        TodoEntity(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: DateTime.now(),
        ),
        TodoEntity(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null,
        ),
      ]);

  void addTodo() {
    state = [
      ...state,
      TodoEntity(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void changeTodoState(TodoEntity todo) {
    final List<TodoEntity> aux = [...state];
    final int index = state.indexOf(todo);

    final TodoEntity newTodo = TodoEntity(
      id: todo.id,
      description: todo.description,
      completedAt: todo.done ? null : DateTime.now(),
    );

    aux.removeAt(index);
    aux.insert(index, newTodo);

    state = [...aux];
  }
}
