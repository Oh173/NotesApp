import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({Key? key, required this.note}) : super(key: key);

  final String note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final editnoteController = TextEditingController();
  final firestore = FirebaseFirestore.instance;

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
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              style: const TextStyle(fontWeight: FontWeight.bold),
              controller: editnoteController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
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
          );
        },
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.update,
            size: 32,
          ),
        ),
      ),
    );
  }
}
