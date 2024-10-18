import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:minimal_todo_getx/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodosController extends GetxController {
  RxList<Todo> todoList;
  RxInt id = 0.obs;

  TodosController(List<Todo> todos) : todoList = RxList(todos) {
    Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      await saveTodos();
    });
  }

  void addTodo(Todo todo) {
    todoList.add(todo);
    saveTodos().then(
      (x) => log('Adding Todo: $x'),
    );
  }

  void incrementId() {
    id.value++;
  }

  void removeTodo(Todo todo) {
    todoList.removeWhere((x) => x.id == todo.id);
    saveTodos().then(
      (x) => log('Removing Todo: $x'),
    );
  }

  Todo getTodo(Todo todo) {
    return todoList.where((x) => x.id == todo.id).first;
  }

  void updateTodo(Todo oldTodo, Todo newTodo) {
    final index = todoList.indexWhere((x) => x.id == oldTodo.id);
    todoList[index] = newTodo;
    saveTodos().then(
      (x) => log('Updating Todo: $x'),
    );
  }

  Future<bool> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(
        "data", todoList.map((x) => jsonEncode(x)).toList());
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList("data") ?? [])
        .map((x) => Todo.fromJson(jsonDecode(x)))
        .toList()
        .obs;
  }
}
