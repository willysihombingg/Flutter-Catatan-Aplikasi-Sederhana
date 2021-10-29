import 'package:catatanaplikasi_flutter/Note.dart';
import 'package:catatanaplikasi_flutter/database.dart';
import 'package:flutter/material.dart';
import 'package:catatanaplikasi_flutter/main.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  var dbHelper;
  final _noteForm = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  submitNote(context) async {
    if (_noteForm.currentState!.validate()) {
      final newNote =
          Note(title: titleController.text, body: bodyController.text);
      await dbHelper.saveNote(newNote).then({
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyApp()))
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Notes"),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, top: 40, left: 20),
        child: Form(
          key: _noteForm,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Isi Judul',
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Some Title';
                  return null;
                },
              ),
              TextFormField(
                controller: bodyController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Isi',
                  hintText: 'Isi Catatan',
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Some Notes';
                  return null;
                },
              ),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => submitNote(context),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
