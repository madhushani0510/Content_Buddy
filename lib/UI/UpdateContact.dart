import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/db.dart';
import '../model/User.dart';

class UpdateContact extends StatelessWidget {
  const UpdateContact(
      this.id, this.name, this.number, this.email, this.imagePath,
      {Key? key})
      : super(key: key);
  final int? id;
  final String name;
  final String number;
  final String? email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final name1 = TextEditingController(text: name);
    final number1 = TextEditingController(text: number);
    final email1 = TextEditingController(text: email);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Update',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Container(
            padding: const EdgeInsets.only(
                top: 10.0, left: 20.0, right: 30.0, bottom: 10.0),
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                      child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )),
                ),
                TextFormField(
                  controller: name1,
                  //initialValue: widget.name,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.amber),
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  //initialValue: widget.number,
                  controller: number1,
                  cursorColor: Colors.black,

                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.amber),
                    labelText: 'Number',
                  ),
                ),
                TextFormField(
                  //initialValue: widget.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: email1,
                  cursorColor: Colors.black,

                  decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.amber),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await Db.instance.update(User(
                        id: id,
                        name: name1.text,
                        number: number1.text,
                        email: email1.text,
                        imgPath: imagePath));

                    name1.clear();
                    number1.clear();
                    email1.clear();
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    primary: Colors.black,
                    backgroundColor: Colors.amber,
                    onSurface: Colors.grey,
                    elevation: 5,
                  ),
                  child: const Text('Update'),
                )
              ],
            )));
  }
}
