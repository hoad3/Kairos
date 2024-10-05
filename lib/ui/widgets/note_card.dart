import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/ui/widgets/create_note.dart';
import 'package:kairos/View/Note/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.index, required this.onDeleteNote, required this.onEditnote});

  final Note note;
  final int index;

  final Function(int) onDeleteNote;
  final Function(Note, int) onEditnote;
  @override
    Widget build(BuildContext context) {
      return Card(
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.body),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => createNote(
                      note: note,
                      index: index,
                      onNewNoteCreated: (updatedNote) => onEditnote(updatedNote, index),
                    )));
              }, icon: Icon(Icons.edit)
              
              ),
              IconButton(onPressed: () => onDeleteNote(index),
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      );
    }
  }

