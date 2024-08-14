import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/screens/widgets/noteScreen.dart';

class createNote extends StatefulWidget {
  const createNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<createNote> createState() => _createNoteState();
}

class _createNoteState extends State<createNote> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 28
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title"
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                  fontSize: 16
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your decription"
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        if(titleController.text.isEmpty)
          {
            return;
          }
        if(bodyController.text.isEmpty){
          return;
        }
        final note = Note(
          body: bodyController.text,
          title: titleController.text
        );

        widget.onNewNoteCreated(note);
        Navigator.of(context).pop();

      },

          child: const Icon(Icons.save),
      ),

    );
  }
}
