import 'package:flutter/material.dart';
import 'package:app_02/notesApp/model/note.dart'; // Đảm bảo chỉ import từ đường dẫn này // Đảm bảo chỉ import từ một đường dẫn
import 'package:app_02/notesApp/db/database_helper.dart'; // Import Database Helper
import 'NoteForm.dart'; // Import NoteForm
import 'NoteDetailScreen.dart'; // Import note_detail_screen.dart

class NoteItem extends StatelessWidget {
  final Note note;
  final Function refreshNotes;

  NoteItem(this.note, this.refreshNotes);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.content),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteDetailScreen(note)),
        );
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteForm(note: note)),
              ).then((_) => refreshNotes());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              if (note.id != null) { // Kiểm tra id khác null
                await NoteDatabaseHelper.instance.deleteNote(note.id!);
                refreshNotes();
              } else {
                // Xử lý trường hợp note.id là null (nếu cần)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không thể xóa ghi chú không có ID.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}