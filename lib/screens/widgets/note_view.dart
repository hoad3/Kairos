
import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.note, required this.index, required this.onDeleteNote});

  final Note note;
  final int index;

  final Function(int) onDeleteNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note view"),
        actions: [
          IconButton(onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Xóa cái này ?"),
                    content: Text("Note ${note.title} will be delete! "),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            onDeleteNote(index);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Delete"
                          ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"
                        ),
                      ),
                    ],
                  );
                },
            );
          },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 20
            ),
          ),

          const SizedBox(height: 10,),

          Text(
            note.body,
            style: const TextStyle(
                fontSize: 16
            ),
          )
        ],
      ),
      ),
    );
  }
}
