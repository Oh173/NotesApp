import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({Key? key, required this.note}) : super(key: key);

  final String note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final editnoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editnoteController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextFormField(
              controller: editnoteController,
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
            String note = editnoteController.text;
          Navigator.pop(
            context,
            note
          );
        },
        child: const Icon(
          Icons.update,
        ),
      ),
    );
  }
}
