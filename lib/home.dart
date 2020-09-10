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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return ListView.builder(
        itemCount: todoController.todos.length,
        itemBuilder: (context, index) {
          return _todoItem(todoController.todos[index], todoController);
        });
  }

// ============================ todo card/listtile widget ============================

  _todoItem(TodoModel todoModel, TodoController todocontroller) {
    return Card(
      elevation: 5,
      child: ListTile(
        onLongPress: () {
          _confirmDelete(todocontroller, todoModel);
        },
        onTap: () {
          todocontroller.checkTodo(todoModel);
        },
        // leading: Container(
        //     width: 10,
        //     child: Icon(
        //       Icons.note,
        //       size: 20,
        //       color: Colors.blue,
        //     )),
        title: todoModel.isDone
            ? Text(
                todoModel.todo,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Raleway',
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey),
              )
            : Text(
                todoModel.todo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Raleway'),
              ),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _confirmDelete(todocontroller, todoModel);
                  },
                ),
              ),
              todoModel.isDone
                  ? Icon(
                      Icons.check_box,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                    ),
            ],
          ),
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
              style: TextStyle(color: Colors.black, fontFamily: 'Raleway'),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.red, fontFamily: 'Raleway')),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.green[900], fontFamily: 'Raleway'),
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          todoTextController.clear();

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.red, fontFamily: 'Raleway')),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.green[900], fontFamily: 'Raleway'),
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
                  maxLength: 100,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                ),
              ),
            ),
            title: Text(
              "New to do item",
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TodoController todocontroller = new TodoController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "To Do It",
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange[300], Colors.orange[400]]))),
      ),
      body: Consumer<TodoController>(builder: (context, todoController, widget) {
        return _buildTodoList(todoController);
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () {
          _showdialog(todocontroller);
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
