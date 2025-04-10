import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();

}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  void _saveNote(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      if (title.isNotEmpty) {
        Navigator.pop(context, title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Catatan Baru'),
        ),
        body: Padding(padding: const EdgeInsets.all(16.0),
          child: Form(key: _formKey, child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Catatan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul catatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _saveNote(context),
                child: Text('Simpan Catatan'),
              ),
            ],
          ),
          ),
        )
    );
  }

}