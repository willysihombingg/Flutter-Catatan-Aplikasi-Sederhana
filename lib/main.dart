import 'package:catatanaplikasi_flutter/Note.dart';
import 'package:catatanaplikasi_flutter/database.dart';
import 'package:catatanaplikasi_flutter/screen/NewNoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:catatanaplikasi_flutter/Note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      home: const MyHomePage(title: 'Aplikasi Catatan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Note>> notes;
  var dbhelper;

  void initState() {
    super.initState();
    dbhelper = DBHelper();
    loadNotes();
  }

  loadNotes() {
    setState(() {
      notes = dbhelper.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: notes,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          var snapshot2 = snapshot;
          if (snapshot.hasData) {
            //Success
            if (snapshot.data!.length == 0)
              return Center(
                child: Text('Still Empty'),
              );

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final currentItem = snapshot.data![index];
                  return ListTile(title: Text('${currentItem.title}'));
                },
              ),
            );
          } else if (snapshot.hasError) {
            //Error
            return Center(
              child: Text('error fetching notes'),
            );
          } else {
            //Loading
            return CircularProgressIndicator();
          }
        },
      ),
      //Membuat tombol add pada screen / UI
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(),
            ),
          );
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
