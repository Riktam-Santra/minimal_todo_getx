import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_todo_getx/controller/todos_controller.dart';

import '../../models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final TodosController _controller = Get.find<TodosController>();
  TodoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          onPressed: () {
            _controller.removeTodo(todo);
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 35,
          )),
      title: Text(
        todo.title,
        style: TextStyle(
            decoration: (todo.completed ?? false)
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      subtitle: todo.subtitle == null ? null : Text(todo.subtitle!),
      trailing: Checkbox(
          value: todo.completed,
          onChanged: (value) {
            final newTodo = todo;
            newTodo.completed = !(todo.completed ?? true);
            _controller.updateTodo(todo, newTodo);
          }),
    );
  }
}
