import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../database/db.dart';
import '../model/User.dart';

class SaveContact extends StatefulWidget {
  const SaveContact({Key? key}) : super(key: key);

  @override
  State<SaveContact> createState() => _SaveContactState();
}

class _SaveContactState extends State<SaveContact> {
  final name = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late String imagetemPath;

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add New Contact',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      // Image radius
                      width: 100,
                      height: 100,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Color.fromARGB(255, 230, 212, 113),
                            ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(
                          Icons.photo_camera,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        label: const Text('Add Picture'),
                        onPressed: () {
                          _onImage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: name,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: number,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Telephone Number',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    await Db.instance.add(User(
                      name: name.text,
                      number: number.text,
                      email: email.text,
                      imgPath: imagetemPath,
                    ));
                    setState(() {
                      name.clear();
                      number.clear();
                      email.clear();

                      Navigator.pop(context, true);
                    });
                  },
                  child: Text('Save'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: Colors.white,
                    backgroundColor: Colors.amber,
                    onSurface: Colors.grey,
                  ),
                )
              ],
            )));
  }

  Future _onImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
      this.imagetemPath = image!.path;
    });
    print(imagetemPath);
  }
}
