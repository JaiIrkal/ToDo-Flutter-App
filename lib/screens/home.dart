import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/ToDo.dart';


// This is the home screen
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.themeIsLight?lightThemeColor:darkAppBarColor,
      appBar: AppBar(
        backgroundColor: Theme.themeIsLight?appBarColor:darkAppBarColor,
        shadowColor: null,
        // This contains all the app bar items
        title: Row(
          children: [
            const Icon(Icons.menu_rounded, color: lightThemeColor, size: 30,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: const Text(
                "Task.io",
                style: TextStyle(
                  color: lightThemeColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  Theme.themeIsLight = !Theme.themeIsLight;
                });
              },
              child: Container(
                child: Icon(Icons.sunny),
              ),
            ),
          ],
        ),
      ),
      // Rest of the body of the app
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Your Tasks',
                      style: TextStyle(
                        color: Theme.themeIsLight?darkAppBarColor:lightThemeTileColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Add to do items when added
                  for(ToDo todoo in todosList.reversed)
                    ToDoItem(
                        todo: todoo,
                        onDeleteItem: _deleteToDoItem,
                        onTodoChanged: _handleToDoChanged
                    ),
                  // The add task container which will input the tasks
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                color: lightThemeTileColor,
                                boxShadow:const [ BoxShadow(
                                    color: lightThemeTileColor,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0
                                )],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _todoController,
                                decoration: const InputDecoration(
                                    hintText: 'Add a Task',
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              right: 20,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _addToDoItem(_todoController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(60,60),
                                primary: Theme.themeIsLight?appBarColor:darkThemeColor,
                                elevation: 5,
                              ),
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Method to delete a function
  void _deleteToDoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id.toString() == id);
    });
  }

  // Method to mark the task as done or not
  void _handleToDoChanged(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // Add a to-do item method
  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(
          ToDo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              todoText: toDo
          )
      );
    });
    _todoController.clear();
  }
}

// A theme class to set and change the theme
class Theme {

  static bool themeIsLight = true;
}

// TodDo item UI
class  ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onTodoChanged;
  final onDeleteItem;

  ToDoItem ({
    Key? key,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        tileColor: Theme.themeIsLight?lightThemeTileColor:darkThemeTaskColor,
        leading: todo.isDone? const Icon(Icons.check_box, color: checkBoxColorComplete,) : const Icon(Icons.check_box, color: checkBoxColorNotComplete,),
        title: Text(todo.todoText.toString(),
          style: TextStyle(
            fontSize: 18,
            color: Theme.themeIsLight?const Color.fromRGBO(0, 0, 0, 1):const Color.fromRGBO(255, 255, 255, 1.0),
            fontWeight: FontWeight.w400,
            decoration: todo.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 35,
          width: 35,
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            color: Colors.red,
            icon: const Icon(Icons.delete),
            iconSize: 25,
          ),
        ),
      ),
    );
  }
}
