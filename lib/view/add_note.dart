import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_application/controller/note_database.dart';
import 'package:note_application/model/style.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';
import '../model/note_provider.dart';

class AddNote extends StatefulWidget {
  static String addRoute = 'add';
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String date = DateFormat.yMMMd().add_jm().format(DateTime.now());
  NoteDatabase noteDatabase = NoteDatabase.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> addNote(Note note) async {
    try {
      await noteDatabase.createNote(note).then((value) =>
          Provider.of<NoteProvider>(context, listen: false).getAllNotes());
    } catch (error) {
      throw Exception('Note not Added in Database');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int i = Random().nextInt(18);
    return Scaffold(
      backgroundColor: Style.mainColor,
      appBar: AppBar(
        backgroundColor: Style.mainColor,
        title: const Text('Add a New Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Style.cardColors[i],
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  hintText: 'Note Title',
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              date,
              style: TextStyle(fontSize: 15, color: Style.cardColors[i]),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Style.cardColors[i],
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: 'Note Content',
                  border: InputBorder.none),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.cardColors[i],
        onPressed: () async {
          await addNote(Note(
                  title: titleController.text,
                  dateTime: date,
                  content: contentController.text))
              .then((value) {
            Navigator.pop(context);
          });
        },
        child: const Icon(
          Icons.save,
          color: Colors.black,
        ),
      ),
    );
  }
}
