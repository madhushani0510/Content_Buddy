import 'dart:io';

import 'package:flutter/material.dart';

import 'package:contactapp/UI/SaveContact.dart';
import 'package:contactapp/UI/UpdateContact.dart';
import 'package:contactapp/database/db.dart';
import 'model/User.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/save': (context) => const SaveContact(),
    },
    home: ContactApp(),
  ));
}

class ContactApp extends StatefulWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  State<ContactApp> createState() => _MyAppState();
}

class _MyAppState extends State<ContactApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contents Buddy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        color: Color.fromARGB(255, 230, 212, 113),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: FutureBuilder<List<User>>(
                  future: Db.instance.getUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<User>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? const Center(child: Text('No Data..'))
                        : ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((contacts) {
                              return Center(
                                child: ListTile(
                                  leading: SizedBox(
                                    child: Image.file(
                                      File(contacts.imgPath!),
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  subtitle: Text(contacts.number),
                                  title: Text(contacts.name),
                                  trailing: Icon(Icons.delete),
                                  onLongPress: () {
                                    onTapDelete(contacts.id!);
                                  },
                                  onTap: () {
                                    onTapUpdate(
                                        context,
                                        contacts.id,
                                        contacts.name,
                                        contacts.number,
                                        contacts.email,
                                        contacts.imgPath);
                                  },
                                ),
                              );
                            }).toList(),
                          );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          onTapFunction(context);
        },
        label: const Text('ADD '),
        backgroundColor: Color.fromARGB(255, 54, 53, 1),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  onTapFunction(BuildContext context) async {
    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaveContact()),
    );

    if (reLoadPage) {
      setState(() {});
    }
  }

  onTapDelete(int id) async {
    await Db.instance.delete(id);
    setState(() {});
  }

  onTapUpdate(BuildContext context, int? id, String name, String number,
      String? email, String? imagePath) async {
    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UpdateContact(id, name, number, email, imagePath!)),
    );

    if (reLoadPage) {
      setState(() {});
    }
  }
}
