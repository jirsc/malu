import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:malu/app/app.dart';
import 'package:malu/config/config.dart';
import 'package:malu/models/food.dart';
import 'package:malu/utils/helpers/string_helper.dart';
import 'package:malu/utils/services/firebase_firestore_service.dart';
import 'package:malu/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:textfield_tags/textfield_tags.dart';

class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: Management());

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  final picker = ImagePicker();
  File? _imageFile;
  late TextEditingController _textEditingControllerName;
  late TextEditingController _textEditingControllerPrice;
  late TextEditingController _textEditingControllerDescription;
  late TextfieldTagsController _textfieldTagsControllerCategory;
  late TextfieldTagsController _textfieldTagsControllerMealType;
  late TextEditingController _textEditingControllerScore;
  int _isRecommended = 0;
  late double _distanceToField;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _textEditingControllerName = TextEditingController();
    _textEditingControllerPrice = TextEditingController();
    _textEditingControllerDescription = TextEditingController();
    _textfieldTagsControllerCategory = TextfieldTagsController();
    _textfieldTagsControllerMealType = TextfieldTagsController();
    _textEditingControllerScore = TextEditingController();
  }

  Future _refresh() async {
    setState(() {});
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

  _insertData() async {
    print('insert data na tayo');

    final food = Food(
      name: _textEditingControllerName.text,
      price: double.tryParse(_textEditingControllerPrice.text) ?? 0,
      description: _textEditingControllerDescription.text,
      category: _textfieldTagsControllerCategory.getTags ?? [],
      mealType: _textfieldTagsControllerMealType.getTags ?? [],
      score: double.tryParse(_textEditingControllerScore.text) ?? 0,
      ratingCount: 5000000,
      recommended: _isRecommended == 0 ? false : true,
    );
    final docRef = db
        .collection("food")
        .withConverter(
          fromFirestore: Food.fromFirestore,
          toFirestore: (Food food, options) => food.toJson(),
        )
        .doc();

    await docRef.set(food);
    print(docRef.id);
    uploadImageToFirebase(docRef);
  }

  Future uploadImageToFirebase(DocumentReference documentReference) async {
    if (_imageFile != null) {
      String fileName = basename(_imageFile!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
          );
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('eto sa upload image part:');
      print(documentReference.id);
      await db
          .collection("food")
          .doc(documentReference.id)
          .set({"imageUrl": downloadUrl}, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    _distanceToField = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    //Scaffold.of(context).appBarMaxHeight!.toDouble(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          _customTextField(_textEditingControllerName, 'Name'),
                          const SizedBox(height: 7),
                          _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(height: 1),
                          TextButton(
                            onPressed: () => pickImage(1),
                            child: const Text('Pick image'),
                          ),
                          const SizedBox(height: 7),
                          TextButton(
                            onPressed: () => pickImage(2),
                            child: const Text('Capture image'),
                          ),
                          const SizedBox(height: 7),
                          _customTextField(
                              _textEditingControllerPrice, 'Price'),
                          const SizedBox(height: 7),
                          _customTextField(
                              _textEditingControllerDescription, 'Description'),
                          const SizedBox(height: 7),
                          _customChipInput(_textfieldTagsControllerCategory,
                              'food category'),
                          const SizedBox(height: 7),
                          _customChipInput(
                              _textfieldTagsControllerMealType, 'meal type'),
                          const SizedBox(height: 7),
                          _customTextField(
                              _textEditingControllerScore, 'Score'),
                          const SizedBox(height: 7),
                          const TextField(),
                          const SizedBox(height: 7),
                          RadioListTile<int>(
                            value: 1,
                            groupValue: _isRecommended,
                            activeColor: theme.primaryColor,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isRecommended = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            value: 0,
                            groupValue: _isRecommended,
                            activeColor: theme.primaryColor,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isRecommended = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 7),
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
          ],
        ),
      ),
    );
  }

  Widget _customTextField(TextEditingController controller, String fieldName) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
        enabled: true,
        errorText:
            isEmpty(value: controller.text) ? null : '${fieldName}_textError',
        //helperText: '${fieldName}_textHelper',
        hintText: 'Input $fieldName',
        labelText: fieldName,
      ),
    );
  }

  Widget _customChipInput(TextfieldTagsController controller, String label) {
    return TextFieldTags(
      textfieldTagsController: controller,
      initialTags: const [
        'enter',
        'something',
      ],
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        print(controller.getTags);
        print(tag);
        if (tag == 'php') {
          return 'No, please just no';
        } else if (controller.getTags!.contains(tag) &&
            controller.getTags!.isNotEmpty) {
          print(controller.getTags);
          print(tag);
          return 'you already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 3.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 3.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                ),
                helperText: 'Enter a $label..',
                helperStyle: TextStyle(
                  color: theme.primaryColor,
                ),
                hintText: controller.hasTags ? '' : "Enter $label..",
                errorText: error,
                prefixIconConstraints:
                    BoxConstraints(maxWidth: _distanceToField * 0.74),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        //clipBehavior: Clip.antiAlias,
                        child: Row(
                            children: tags.map((String tag) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: theme.primaryColor,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '#$tag',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
    );
  }
}
