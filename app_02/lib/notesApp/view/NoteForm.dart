// lib/notesApp/view/note_form.dart
import 'package:app_02/notesApp/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:app_02/notesApp//db/database_helper.dart';

class NoteForm extends StatefulWidget {
  final Note? note;

  NoteForm({this.note});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _priority = 1;
  List<String> _tags = [];
  Color _selectedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _priority = widget.note!.priority;
      _tags = widget.note!.tags ?? [];
      _selectedColor = Color(int.parse(widget.note!.color ?? '0xFFFFFFFF'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Thêm Ghi chú' : 'Sửa Ghi chú'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Nội dung'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Mức độ ưu tiên:'),
                  Radio<int>(
                    value: 1,
                    groupValue: _priority,
                    onChanged: (value) => setState(() => _priority = value!),
                  ),
                  Text('Thấp'),
                  Radio<int>(
                    value: 2,
                    groupValue: _priority,
                    onChanged: (value) => setState(() => _priority = value!),
                  ),
                  Text('Trung bình'),
                  Radio<int>(
                    value: 3,
                    groupValue: _priority,
                    onChanged: (value) => setState(() => _priority = value!),
                  ),
                  Text('Cao'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Chọn Màu'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: _selectedColor,
                            onColorChanged: (color) => setState(() => _selectedColor = color),
                            enableAlpha: true, // Sửa ở đây
                            pickerAreaHeightPercent: 0.8,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Chọn'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Chọn Màu'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tags (cách nhau bằng dấu phẩy)'),
                onChanged: (value) => _tags = value.split(','),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final now = DateTime.now();
                    final note = Note(
                      id: widget.note?.id, // Sửa ở đây
                      title: _titleController.text,
                      content: _contentController.text,
                      priority: _priority,
                      createdAt: widget.note?.createdAt ?? now,
                      modifiedAt: now,
                      tags: _tags,
                      color: _selectedColor.value.toRadixString(16),
                    );
                    if (widget.note == null) {
                      await NoteDatabaseHelper.instance.insertNote(note);
                    } else {
                      await NoteDatabaseHelper.instance.updateNote(note);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.note == null ? 'Lưu' : 'Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}