import 'package:note_application/model/constants.dart';

class Note {
  final int? id;
  final String? title;
  final String? dateTime;
  final String? content;

  Note({this.id, this.title, this.dateTime, this.content});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map[columnId],
        title: map[columnTitle],
        dateTime: map[columnDateTime],
        content: map[columnContent]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnTitle: title,
      columnDateTime: dateTime,
      columnContent: content
    };
  }
}
