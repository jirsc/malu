import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:malu/app/app.dart';
import 'package:malu/config/config.dart';
import 'package:malu/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: Management());

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  final picker = ImagePicker();
  late File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sige go lang ;)',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            key: const Key('managementPage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              //Scaffold.of(context).appBarMaxHeight!.toDouble(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    TextField(),
                    SizedBox(height: 7),
                    _imageFile.existsSync()
                        ? Image.file(
                            _imageFile,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(height: 1),
                    TextButton(
                      onPressed: () => pickImage(1),
                      Widget: Text('Pick image'),
                    ),
                    SizedBox(height: 7),
                    TextButton(
                      onPressed: () => pickImage(2),
                      Widget: Text('Capture image'),
                    ),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7.0),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: FullWidthButton(
                      'Okay na ako, send!',
                      color: theme.primaryColor,
                      onPressed: () => _insertData(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage(int type) async {
    final pickedFile = await picker.pickImage(
      source: type == 1 ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 210,
      maxHeight: 210,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  _insertData() {
    print('insert data na tayo');
    uploadImageToFirebase();
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    /* await FirebaseFirestore.instance
        .collection(_imageFile.path)
        .add({"url": downloadUrl, "name": fileName}); */
  }
}
