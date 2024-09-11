import 'package:flutter/material.dart';

import 'todo.dart';

import 'item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();

    // give a color
    AppBar _AppBar() {
      return AppBar(
        title: Text('Project 3 - Reminders!'),
        backgroundColor: Color.fromARGB(255, 164, 226, 255),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(223, 211, 241, 255),
      appBar: _AppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      searchBox(), //search widget on top
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: const Text(
                          'Tasks',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      for (ToDo todoReverse in _foundToDo.reversed)
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          child: ToDoItem(
                            todo: todoReverse,
                            onToDoChanged: _changeToDo,
                            onDeleteItem: _deleteToDo,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a task', border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 30,
                  right: 30,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  onPressed: () {
                    _addToDo(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    minimumSize: Size(60, 60),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _changeToDo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // delete an item

  void _deleteToDo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

// add to the list using DateTime
  void _addToDo(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
        category: '',
      ));
    });
    _todoController.clear();
  }

// Search function
  void _searchTask(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  // give a color
  AppBar _AppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlue,
      title: Text('Project 3 Todo!'),
    );
  }

/* search box
keep small and at top of screen so it doesn't interfere with adding tasks
use hinttext for lighter text

*/
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _searchTask(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search for a task',
          hintStyle: TextStyle(color: Colors.lightBlue),
        ),
      ),
    );
  }
}
