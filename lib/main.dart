import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_todo_getx/controller/todos_controller.dart';
import 'package:minimal_todo_getx/view/home_page.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  final _controller = TodosController([]);
  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white),
      home: FutureBuilder(
        future: _controller.loadTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    "Unable to create fetch any older Todos, lets start fresh!"),
                action: SnackBarAction(label: "Dismiss", onPressed: () {}),
              ),
            );
          }

          Get.put(_controller);
          return const HomePage();
        },
      ),
    );
  }
}
