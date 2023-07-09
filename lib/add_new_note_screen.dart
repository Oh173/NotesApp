import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddNewNoteScreen extends StatefulWidget {
  const AddNewNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNewNoteScreen> createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final noteController = TextEditingController();
  final fireStore = FirebaseFirestore.instance;
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: noteController,
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
        onPressed: () => addNote(),
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
            Icons.save,
            size: 32,
          ),
        ),
      ),
    );
  }

  addNote() {
    String note = noteController.text;

    String currentMillis = DateTime.now().microsecondsSinceEpoch.toString();

    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> data = {
      'id': currentMillis,
      'note': note,
      'userId' : userId,
    };

    fireStore.collection('notes').doc(data['id']).set(data);

    Navigator.pop(
      context,
    );
  }
}
