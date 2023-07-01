import 'package:flutter/material.dart';

class AddNewNoteScreen extends StatelessWidget {
  AddNewNoteScreen({Key? key}) : super(key: key);

  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextFormField(
              controller: noteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Note',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String note = noteController.text;
          Navigator.pop(
            context,
            note,
          );
        },
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}
