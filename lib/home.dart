import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/todoController.dart';
import 'package:todo_list/todoModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// ============================ todo list builder ============================

  TextEditingController todoTextController = new TextEditingController();

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }

  _buildTodoList(TodoController todoController) {
    return ListView.builder(
        itemCount: todoController.todos.length,
        itemBuilder: (context, index) {
          return _todoItem(todoController.todos[index], todoController);
        });
  }

// ============================ todo card/listtile widget ============================

  _todoItem(TodoModel todoModel, TodoController todocontroller) {
    return Card(
      elevation: 2,
      child: ListTile(
        onLongPress: () {
          _confirmDelete(todocontroller, todoModel);
        },
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
      ),
    );
  }
// ============================ show dialog to confirm todo remove ============================

  void _confirmDelete(TodoController todocontroller, TodoModel todoModel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(
              "Are you sure?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  todocontroller.deleteTodo(todoModel);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

// ============================ show dialog to create new todo ============================
  void _showdialog(TodoController todocontroller) {
    final String textval = todoTextController.text;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          todoTextController.clear();

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => {
                  Provider.of<TodoController>(context, listen: false)
                      .addTodo(TodoModel(todo: todoTextController.text.toString(), isDone: false)),
                  Navigator.pop(context),
                },
              )
            ],
            content: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(1),
                padding: EdgeInsets.only(bottom: 1.0),
                height: 100,
                width: 300,
                child: TextField(
                  controller: todoTextController,
                  maxLength: 50,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            title: Text(
              "New todo item",
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TodoController todocontroller = new TodoController();
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Consumer<TodoController>(builder: (context, todoController, widget) {
        return _buildTodoList(todoController);
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () {
          _showdialog(todocontroller);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
