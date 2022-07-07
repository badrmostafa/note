import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_application/controller/note_database.dart';
import 'package:note_application/model/note_provider.dart';
import 'package:note_application/model/style.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';

class EditNote extends StatefulWidget {
  const EditNote({required this.note, Key? key}) : super(key: key);

  final Note note;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String date = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  NoteDatabase noteDatabase = NoteDatabase.instance;
  late int noteId;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title!;
    contentController.text = widget.note.content!;
    noteId = widget.note.id!;
  }

  Future<void> editNote(Note note) async {
    try {
      await noteDatabase.updateNote(note).then((value) =>
          Provider.of<NoteProvider>(context, listen: false).getAllNotes());
    } catch (error) {
      throw Exception('Note not be edit');
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
        title: const Text('Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Style.cardColors[i],
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                  hintText: 'Note Title'),
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
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Style.cardColors[i],
                  hintStyle: const TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  hintText: 'Note Content'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.cardColors[i],
        onPressed: () async {
          await editNote(Note(
                  id: noteId,
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
