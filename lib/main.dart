import 'package:flutter/material.dart';

class Note {
  final String title;
  final String description;
  Note({
    required this.title,
    required this.description,
  });
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  List<Note> notes = [];
  void addNote() async {
    final Note? newNote = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';

        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(Note(
                  title: title,
                  description: description,
                ));
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (newNote != null) {
      setState(() {
        notes.add(newNote);
      });
    }
  }

  void viewNoteDetails(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(note.title),
          content: Text(note.description),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  notes.remove(note);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Home Work Diary'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          final note = notes[index];
          return Card(
            elevation: 1,
            child: ListTile(
              title: Text(note.title , style: TextStyle(fontWeight:FontWeight.bold),),
              onTap: () {
                viewNoteDetails(note);
              },
          
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add),
        tooltip: 'Add Note',
        onPressed: () {
          addNote();
        },
      ),
    );
  }
}void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
