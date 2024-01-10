// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:pinkytodo/utilities/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  //text input field controller for holding input text
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    //Pop up dialog for new task submit
    return AlertDialog(
      backgroundColor: Colors.pink.shade100,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink.shade300,
                    width: 2,
                  ),
                ),
                hintText: "What to do next?",
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.pink.shade300,
                ),
              ),
              style: const TextStyle(fontStyle: FontStyle.normal),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
