import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:pinkytodo/data/database.dart';
import 'package:pinkytodo/utilities/dialog_box.dart';
import 'package:pinkytodo/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference my hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.initData();
    } else {
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  // List db.toDoList = [
  //   ["What do you wanna do today?", false],
  // ];

  void markStatus(bool? val, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => {
            _controller.clear(),
            Navigator.of(context).pop(),
          },
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pinky To-Do",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.event_note,
                size: 400,
                color: Colors.pink.shade100,
              ),
            ),
          ),
          ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskStatus: db.toDoList[index][1],
                onChanged: (value) => markStatus(value, index),
                deleteTask: (content) => deleteTask(index),
              );
            },
          ),
        ],
      ),
      // Add task button on the right bottom
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.pink.shade200,
          child: const Icon(
            Icons.add,
            size: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
