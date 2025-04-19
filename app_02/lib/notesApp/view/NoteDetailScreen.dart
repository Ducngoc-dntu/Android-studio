import 'package:flutter/material.dart';
import 'package:app_02/notesApp/db/database_helper.dart'; // Import Database Helper
import 'package:app_02/notesApp/model/note.dart'; // Import Note model
import 'NoteForm.dart'; // Import NoteForm
import 'NoteItem.dart'; // Import NoteItem

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(note.content),
      ),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final dbHelper = NoteDatabaseHelper.instance;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final allNotes = await dbHelper.getAllNotes(); // Thêm await ở đây
    setState(() {
      notes = allNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ghi chú của bạn'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNotes,
          ),
          // Thêm các nút lọc, tìm kiếm, v.v.
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteItem(notes[index], _refreshNotes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteForm()),
          ).then((_) => _refreshNotes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}