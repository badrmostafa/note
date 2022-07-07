import 'dart:async';

import 'package:flutter/material.dart';

import '../controller/note_database.dart';
import 'note_model.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];
  NoteDatabase noteDatabase = NoteDatabase.instance;

  StreamController<List<Note>> streamController =
      StreamController<List<Note>>();

  Future<List<Note>> getAllNotes() async {
    try {
      notes = await noteDatabase.getNotes();
      streamController.add(notes);
      notifyListeners();
      return notes;
    } catch (error) {
      throw Exception('Error During Get Notes');
    }
  }
}
