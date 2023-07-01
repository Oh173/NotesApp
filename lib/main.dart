import 'package:flutter/material.dart';
import 'package:notesscreen/add_new_note_screen.dart';
import 'package:notesscreen/edit_note_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.dark),
      home: const NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Notes",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddNewNoteScreen();
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return noteItem(index);
        },
      ),
    );
  }

  Widget noteItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(26),
      ),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              notes[index],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              navigateToEditNewNoteScreen(index);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              notes.removeAt(index);
              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAddNewNoteScreen() {
    Navigator.of(
     context
    ).push(MaterialPageRoute(builder: (context) => AddNewNoteScreen()))
        .then((value) {
      if (value == null) {
        return;
      }
      notes.add(value);
      setState(() {});
    });
  }

  void navigateToEditNewNoteScreen(int index) {
    Navigator.of(
        context
    ).push(MaterialPageRoute(builder: (context) =>  EditNoteScreen(note: notes[index],)))
        .then((value) {

      if (value == null) {
        return;
      }
         print(value);
         notes[index] = value;
         setState(() {
         });
    });
  }


}

