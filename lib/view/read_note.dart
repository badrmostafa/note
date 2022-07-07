import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_application/model/style.dart';

import '../model/note_model.dart';

class ReadNote extends StatefulWidget {
  const ReadNote({required this.note, Key? key}) : super(key: key);
  final Note note;
  @override
  State<ReadNote> createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
  int i = Random().nextInt(15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.mainColor,
      appBar: AppBar(
        backgroundColor: Style.mainColor,
        title: const Text('Read Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 300, left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Style.cardColors[i]),
          child: Column(
            children: [
              Text('${widget.note.title}', style: Style.mainTitle),
              const SizedBox(
                height: 20,
              ),
              Text('${widget.note.dateTime}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              const SizedBox(
                height: 25,
              ),
              Text('${widget.note.content}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
