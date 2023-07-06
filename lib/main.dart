import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notesscreen/add_new_note_screen.dart';
import 'package:notesscreen/constants/colors.dart';
import 'package:notesscreen/edit_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.grey.shade900.value, {
          50: Colors.grey.shade50,
          100: Colors.grey.shade100,
          200: Colors.grey.shade200,
          300: Colors.grey.shade300,
          400: Colors.grey.shade400,
          500: Colors.grey.shade500,
          600: Colors.grey.shade600,
          700: Colors.grey.shade700,
          800: Colors.grey.shade800,
          900: Colors.grey.shade900
        }),
        textTheme: GoogleFonts.josefinSansTextTheme(),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
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
  final List<Map<String, dynamic>> notes = [];
  final firestore = FirebaseFirestore.instance;
  bool isVisible = false;

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    super.initState();
    getNotesFromFire();
  }


  void getNotesFromFire() {
    firestore.collection('notes').get().then((value) {
      notes.clear();
      for (var document in value.docs) {
        final note = document.data();
        notes.add(note);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                });
              },
              padding: const EdgeInsets.all(0),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(.8),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            navigateToAddNewNoteScreen();
          },
          elevation: 0,
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
              Icons.add,
              size: 32,
            ),
          ),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if(!isVisible) setState(() => isVisible = true);
          } else if (notification.direction == ScrollDirection.reverse) {
            if(isVisible) setState(() => isVisible = false);
          }
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search notes...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return noteItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noteItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        color: getRandomColor(),
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  notes[index]['note'],
                  style: GoogleFonts.josefinSans(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateToEditNewNoteScreen(index);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black38,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await confirmDialog(context);
                  if (result != null && result) {
                    deleteNote(index);
                  }
                  },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToAddNewNoteScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddNewNoteScreen()))
        .then((value) {
      getNotesFromFire();
    });
  }

  void navigateToEditNewNoteScreen(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditNoteScreen(
                  note: notes[index]['note'],
                )))
        .then((value) {
      if (value == null) {
        return;
      }
      print(value);
      notes[index] = value;
      setState(() {});
    });
  }

  deleteNote(int index) async {
    await firestore.collection('notes').doc(notes[index]['id']).delete();
    notes.removeAt(index);
    setState(() {});
  }

  confirmDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        icon: const Icon(
          Icons.info,
          color: Colors.grey,
        ),
        title: const Text(
          'Are you sure you want to delete?',
          style: TextStyle(color: Colors.white),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ),
          ],
        ),
      );
    });
  }
}
