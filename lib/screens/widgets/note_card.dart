import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/screens/widgets/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.index, required this.onDeleteNote});

  final Note note;
  final int index;

  final Function(int) onDeleteNote;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder:(context) =>NoteView(note: note, index: index, onDeleteNote: onDeleteNote,)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
      
              const SizedBox(height:  10),
      
              Text(
                note.body,
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
