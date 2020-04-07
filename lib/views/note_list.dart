import 'package:flutter/material.dart';
import 'package:notes/models/note_for_listing.dart';
import 'package:notes/views/notes_modify.dart';
import 'note_delete.dart';

final notes = [
  new NoteForListing(
      noteId: "1",
      createDateTime: DateTime.now(),
      lastEditDateTime: DateTime.now(),
      noteTitle: "Note 1"),
  new NoteForListing(
      noteId: "2",
      createDateTime: DateTime.now(),
      lastEditDateTime: DateTime.now(),
      noteTitle: "Note 2"),
  new NoteForListing(
      noteId: "3",
      createDateTime: DateTime.now(),
      lastEditDateTime: DateTime.now(),
      noteTitle: "Note 3"),
];

String formatDateTime(DateTime dateTime) {
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (_, index) {
            return Dismissible(
              key: ValueKey(notes[index].noteId),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => NoteDelete());
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16.0),
                child: Align(child: Icon(Icons.delete, color: Colors.white,),),
              ),
              child: ListTile(
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    'Last modified on ${formatDateTime(notes[index].lastEditDateTime)}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NoteModify(
                            noteID: notes[index].noteId,
                          )));
                },
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.green,
              ),
          itemCount: notes.length),
    );
  }
}
