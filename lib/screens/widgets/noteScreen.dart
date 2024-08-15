import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kairos/models/note_models.dart';
import 'package:kairos/screens/create_note.dart';
import 'package:kairos/screens/widgets/note_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class noteScreen extends StatefulWidget {
  const noteScreen({super.key});

  @override
  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter note"),
        backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
          icon: Icon(Icons.arrow_back),

        ),
      ),
      body: ListView.builder(itemCount: notes.length,
      itemBuilder: (context, index){
        return NoteCard(note: notes[index], index: index, onDeleteNote:onDeleteNote, onEditnote: onEditNoteUpdated,);
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => createNote(onNewNoteCreated: onNewNoteCreated)));
      },
        child: const Icon(Icons.add),
      ),

    );
  }
//lưu lại note khi thoát ứng dụng
  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesJson = notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', notesJson);
  }
//tạo note
  void onNewNoteCreated(Note note){
    notes.add(note);
    saveNotes();
    setState(() {

    });
  }
  //xóa note
  void onDeleteNote(int index){
    notes.removeAt(index);
    saveNotes();
    setState(() {

    });
  }

  //sửa note
  void onEditNoteUpdated(Note updatedNote, int index) {
    notes[index] = updatedNote;
    saveNotes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

// Tải ghi chú từ SharedPreferences
  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesJson = prefs.getStringList('notes');
    if (notesJson != null) {
      notes = notesJson.map((note) => Note.fromJson(jsonDecode(note))).toList();
      setState(() {});
    }
  }
}
