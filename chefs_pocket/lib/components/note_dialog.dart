import 'package:flutter/material.dart';

class NoteDialog extends StatefulWidget {
  final String initialNote;
  final Function(String) onSave;

  NoteDialog({required this.initialNote, required this.onSave});

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late TextEditingController textEditingController;
  late String newNote;

  @override
  void initState() {
    super.initState();
    newNote = widget.initialNote;
    textEditingController = TextEditingController(text: widget.initialNote);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modifica note'),
      content: TextField(
        onChanged: (value) {
          newNote = value;
        },
        controller: textEditingController,
      ),
      actions: [
        TextButton(
          child: Text('Annulla'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Salva'),
          onPressed: () {
            widget.onSave(newNote);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}