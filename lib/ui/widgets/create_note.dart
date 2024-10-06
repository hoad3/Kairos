import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/ui/widgets/noteScreen.dart';

class createNote extends StatefulWidget {
  const createNote(
      {super.key, required this.onNewNoteCreated, this.note, this.index});

  // final Function(Note)? onNoteUpdated;
  final Note? note;
  final int? index;

  final Function(Note) onNewNoteCreated;


    @override
    State<createNote> createState() => _createNoteState();
  }

class _createNoteState extends State<createNote> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      bodyController.text = widget.note!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Create note" : "Edit note"),

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
              style: const TextStyle(fontSize: 16),
              keyboardType: TextInputType.multiline, // Cho phép nhập nhiều dòng
              maxLines: null, // Cho phép số dòng không giới hạn
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Your description",
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
