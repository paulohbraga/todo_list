import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/todoModel.dart';

class TodoController extends ChangeNotifier {
  TodoController() {
    fetchTodos();
  }

  List<TodoModel> todos = [];
  String todosString;
  bool isFetching = false;

  Future<void> fetchTodos() async {
    isFetching = true;
    final prefs = await SharedPreferences.getInstance();
    todosString = prefs.getString("todo");
    todos = getTodosJson();
    isFetching = false;
    notifyListeners();
  }

  List<TodoModel> getTodosJson() {
    List<TodoModel> parsedTodos = List<TodoModel>.from(json.decode(todosString).map((x) => TodoModel.fromJson(x)));
    return parsedTodos;
  }

  checkTodo(TodoModel todoModel) async {
    final prefs = await SharedPreferences.getInstance();
    todoModel.isDone = !todoModel.isDone;
    prefs.setString("todo", json.encode(todos));

    notifyListeners();
  }

  deleteTodo(TodoModel todoModel) async {
    final prefs = await SharedPreferences.getInstance();
    todos.remove(todoModel);
    prefs.setString("todo", json.encode(todos));
    notifyListeners();
  }

  addTodo(TodoModel todoModel) async {
    final prefs = await SharedPreferences.getInstance();
    if (todoModel.todo.isNotEmpty) {
      todos.add(todoModel);
      prefs.setString("todo", json.encode(todos));
      notifyListeners();
    }
  }
}
