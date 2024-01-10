import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [
    ["What do you wanna do today?", false],
  ];
  //ref the box, it's already initialized in `main` with `openBox`
  final _myBox = Hive.box('myBox');

// init on first time ever opening
  void initData() {
    toDoList = [
      ["What do you wanna do today?", false]
    ];
  }

  //load data from db if it's not the first time ever
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update db whenever necessary
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
