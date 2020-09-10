class TodoModel {
  TodoModel({this.todo, this.isDone});

  String todo;
  bool isDone;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        todo: json["todo"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        'todo': todo,
        'isDone': isDone,
      };
}
