import 'dart:math';
import 'package:flutter/material.dart';
import 'package:note_application/controller/note_database.dart';
import 'package:note_application/model/note_provider.dart';
import 'package:note_application/model/style.dart';
import 'package:note_application/view/edit_note.dart';
import 'package:note_application/view/read_note.dart';
import 'package:provider/provider.dart';

import 'note_model.dart';

Widget noteCard(BuildContext buildContext, Note note) {
  int index = Random().nextInt(18);

  return GestureDetector(
    onTap: () {
      Navigator.push(buildContext, MaterialPageRoute(builder: (context) {
        return ReadNote(
          note: note,
        );
      }));
    },
    child: Card(
      color: Style.cardColors[index],
      margin: const EdgeInsets.all(3),
      child: Column(
        children: [
          Text(
            '${note.title}',
            overflow: TextOverflow.ellipsis,
            style: Style.mainTitle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text('${note.dateTime}'),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${note.content}',
            overflow: TextOverflow.ellipsis,
            style: Style.mainContent,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    removeNote(note.id).then((value) =>
                        Provider.of<NoteProvider>(buildContext, listen: false)
                            .getAllNotes());
                  },
                  child: const Icon(Icons.delete)),
              const SizedBox(
                width: 7,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(buildContext, MaterialPageRoute(
                      builder: (context) {
                        return EditNote(note: note);
                      },
                    ));
                  },
                  child: const Icon(Icons.edit))
            ],
          )
        ],
      ),
    ),
  );
}

NoteDatabase noteDatabase = NoteDatabase.instance;
Future<void> removeNote(int? id) async {
  try {
    await noteDatabase.deleteNote(id!);
  } catch (error) {
    throw Exception('Note not Deleted');
  }
}
