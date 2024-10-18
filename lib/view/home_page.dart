import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_todo_getx/controller/todos_controller.dart';
import 'package:minimal_todo_getx/view/widgets/todo_tile.dart';

import '../models/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.7,
                      1,
                    ],
                    colors: [Color.fromARGB(0, 255, 255, 255), Colors.white],
                  ),
                ),
                height: constraints.maxHeight / 2,
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth / 3,
                ),
                child: Obx(
                  () {
                    final TodosController controller =
                        Get.find<TodosController>();
                    if (controller.todoList.isEmpty) {
                      return const Center(
                        child: Text("You have no Todos."),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: controller.todoList
                          .asMap()
                          .keys
                          .map(
                            (x) => TodoTile(
                              key: Key("$x"),
                              todo: controller.todoList[x],
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>
                      _showDialog(context, Get.find<TodosController>()),
                ),
                label: const Text("Create a todo"),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        );
      }),
    );
  }

  SimpleDialog _showDialog(BuildContext context, TodosController controller) {
    String title = "";
    String? subtitle;
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16),
      title: const Text("Create new todo"),
      alignment: Alignment.center,
      children: [
        TextField(
          decoration: const InputDecoration(hintText: "Todo Title"),
          onChanged: (value) {
            title = value;
          },
        ),
        TextField(
          decoration:
              const InputDecoration(hintText: "Todo Description (Optional)"),
          onChanged: (value) {
            subtitle = value;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (title.isEmpty) return;
                controller.todoList.add(
                  Todo(controller.id.value, title, subtitle),
                );
                controller.incrementId();
                Navigator.pop(context);
              },
              child: const Text("Add Todo"),
            ),
          ],
        )
      ],
    );
  }
}
