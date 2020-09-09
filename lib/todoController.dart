import 'package:flutter/material.dart';
import 'package:todo_list/todoModel.dart';

class TodoController extends ChangeNotifier {
  List<TodoModel> todos = [
    TodoModel(todo: "Buy tomatoes", isDone: true),
    TodoModel(todo: "Study Flutter", isDone: false),
    TodoModel(todo: "Pay accounts", isDone: false),
    TodoModel(todo: "Test new program", isDone: false),
    TodoModel(todo: "Wash the car", isDone: false),
    TodoModel(todo: "Go to the gym", isDone: false),
    TodoModel(todo: "Buy tomatoes", isDone: true),
    TodoModel(todo: "Study Flutter", isDone: false),
    TodoModel(todo: "Pay accounts", isDone: false),
    TodoModel(todo: "Test new program", isDone: false),
    TodoModel(todo: "Wash the car", isDone: false),
    TodoModel(todo: "Go to the gym", isDone: false),
    TodoModel(todo: "Buy tomatoes", isDone: true),
    TodoModel(todo: "Study Flutter", isDone: false),
    TodoModel(todo: "Pay accounts", isDone: false),
    TodoModel(todo: "Test new program", isDone: false),
    TodoModel(todo: "Wash the car", isDone: false),
    TodoModel(todo: "Go to the gym", isDone: false),
  ];

  checkTodo(TodoModel todoModel) {
    todoModel.isDone = !todoModel.isDone;
    notifyListeners();
  }

  deleteTodo(TodoModel todoModel) {
    todos.remove(todoModel);
    notifyListeners();
  }
}
