import 'package:flutter/material.dart';
import 'package:app_02/notesApp/db/database_helper.dart';
import 'package:app_02/notesApp/model/note.dart';
import 'NoteForm.dart';
import 'NoteItem.dart';

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
    try {
      final allNotes = await dbHelper.getAllNotes();
      setState(() {
        notes = allNotes;
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tải ghi chú: $e')),
      );
    }
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