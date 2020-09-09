import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/todoController.dart';
import 'package:todo_list/todoModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _buildTodoList(TodoController todoController) {
    return ListView.builder(
        itemCount: todoController.todos.length,
        itemBuilder: (context, index) {
          return _todoItem(todoController.todos[index], todoController);
        });
  }

  _todoItem(TodoModel todoModel, TodoController todocontroller) {
    return ListTile(
      onLongPress: () {},
      onTap: () {
        print("clicou");
        todocontroller.checkTodo(todoModel);
      },
      title: Text(todoModel.todo),
      trailing: todoModel.isDone
          ? Icon(
              Icons.check_box,
              color: Colors.green,
            )
          : Icon(
              Icons.check_box_outline_blank,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: Consumer<TodoController>(builder: (context, todoController, widget) {
          return _buildTodoList(todoController);
        }));
  }
}
