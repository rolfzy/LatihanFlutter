import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'add_note_screen.dart';
import 'notes.dart';

class NoteMainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<NoteMainScreen> {
  List<Note> notes = [];
  bool isLoading = true;
  String errorMessage = '';
  SharedPreferences?_prefs;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await _loadCompletedStatus();
    await _fecthNotesFromApi();
  }

  Future<void> _loadCompletedStatus() async {
    _prefs = await SharedPreferences.getInstance();

    for (var note in notes) {
      note.isCompleted = _prefs?.getBool('note_${note.id}') ?? false;
    }
    if (mounted) {
      setState(() {

      });
    }
  }

  Future<void> _fecthNotesFromApi() async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notes = data.map((json) => Note.fromJson(json)).toList();
          isLoading = false;
          _loadCompletedStatus();
        });
      } else {
        setState(() {
          errorMessage =
          'Gagal mengambil data: Status code ${response.statusCode}';
          isLoading = false;
          _loadCompletedStatus();
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Terjadi kesalahan: $error';
        isLoading = false;
      });
    }
  }

  void _addNote(String title) {
    setState(() {
      final newNote = Note(title: title);
      notes.add(newNote);
    });
  }

  void _toggleComplete(Note note) {
    setState(() {
      note.isCompleted = !note.isCompleted;
      _prefs?.setBool('note_${note.id}', note.isCompleted);
    });
  }

  void _navigateToAddNoteScreen() async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddNoteScreen()),
    );
    if (result != null && result is String) {
      _addNote(result);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Sederhana'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : errorMessage.isNotEmpty
            ? Text(errorMessage)
            : notes.isEmpty
            ? Text('Tidak ada catatan.')
            : ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: note.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    Checkbox(
                      value: note.isCompleted,
                      onChanged: (bool? value) {
                        if (value != null) {
                          _toggleComplete(note);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNoteScreen,
        child: Icon(Icons.add),
      ),
    );
  }

}
