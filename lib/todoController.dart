import 'package:flutter/material.dart';
import 'package:todo_list/todoModel.dart';

class TodoController extends ChangeNotifier {
  List<TodoModel> todos = [
    TodoModel(todo: "Long press to delete", isDone: true),
    TodoModel(todo: "Your to-dos", isDone: false),
  ];

  checkTodo(TodoModel todoModel) {
    todoModel.isDone = !todoModel.isDone;
    notifyListeners();
  }

  deleteTodo(TodoModel todoModel) {
    todos.remove(todoModel);
    notifyListeners();
  }

  addTodo(TodoModel todoModel) {
    todos.add(todoModel);
    notifyListeners();
  }
}
