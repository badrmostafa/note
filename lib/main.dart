import 'package:flutter/material.dart';
import 'package:note_application/model/note_provider.dart';
import 'package:note_application/view/add_note.dart';
import 'package:note_application/view/note_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        routes: {
          AddNote.addRoute: (context) => const AddNote(),
          NoteHome.homeRoute: (context) => const NoteHome(),
        },
        home: const NoteHome(),
      ),
    );
  }
}
