// Logic behind the todo app
class ToDo{

  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDo> todoList(){
    return[
      ToDo(id: "First", todoText: "Enter task below and press +", isDone: false),
    ];
  }
}