import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_application/model/note_provider.dart';
import 'package:note_application/model/note_card.dart';
import 'package:note_application/model/style.dart';
import 'package:note_application/view/add_note.dart';
import 'package:provider/provider.dart';

import '../controller/note_database.dart';
import '../model/note_model.dart';

class NoteHome extends StatefulWidget {
  static const String homeRoute = 'home';
  const NoteHome({Key? key}) : super(key: key);

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  late Future<List<Note>> future;

  @override
  void initState() {
    super.initState();
    future = Provider.of<NoteProvider>(context, listen: false).getAllNotes();
  }

  NoteDatabase noteDatabase = NoteDatabase.instance;
  Future<void> removeNote(int? id) async {
    try {
      await noteDatabase.deleteNote(id!);
    } catch (error) {
      throw Exception('Note not Deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    int i = Random().nextInt(18);
    return Scaffold(
        backgroundColor: Style.mainColor,
        appBar: AppBar(
          backgroundColor: Style.mainColor,
          title: const Text('Add Note'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Add Recent Notes',
                      style: TextStyle(
                          color: Style.cardColors[i],
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey,
                        onPressed: () {
                          Navigator.pushNamed(context, AddNote.addRoute);
                        },
                        child: Icon(
                          Icons.add,
                          color: Style.cardColors[i],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<NoteProvider>(builder: (context, provider, child) {
                  return FutureBuilder<List<Note>>(
                      future: future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (provider.notes.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              controller:
                                  ScrollController(keepScrollOffset: true),
                              itemCount: provider.notes.length,
                              itemBuilder: (context, i) {
                                return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (dir) {
                                      removeNote(provider.notes[i].id)
                                          .then((value) {
                                        provider.getAllNotes();
                                      });
                                    },
                                    child:
                                        noteCard(context, provider.notes[i]));
                              },
                            );
                          } else {
                            return const Text('There\'s no Notes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600));
                          }
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                }),
              ],
            ),
          ),
        ));
  }
}
