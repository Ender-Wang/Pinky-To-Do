// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 0),

      //Slide to delete
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),

        //Task detail: Checkbox + Text
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              //check box
              Checkbox(
                value: taskStatus,
                onChanged: onChanged,
                checkColor: Colors.black,
                activeColor: Colors.pink.shade100,
              ),

              //Task text
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration:
                          taskStatus ? TextDecoration.lineThrough : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
