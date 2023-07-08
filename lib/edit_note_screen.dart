import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    Key? key,
    required this.note,
    required this.id,
  }) : super(key: key);

  final String note;
  final String id;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final editNoteController = TextEditingController();

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white));

  @override
  void initState() {
    super.initState();
    editNoteController.text = widget.note;
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
              controller: editNoteController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Note',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => updateNote(),
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

  updateNote() {
    String note = editNoteController.text;
    final fireStore = FirebaseFirestore.instance;

    Map<String, dynamic> data = {
      'note': note,
    };
    fireStore.collection("notes").doc(widget.id).update(data);
    Navigator.pop(context, note);
    setState(() {});
  }
}
