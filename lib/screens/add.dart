import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/database/functions/db_functions.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/screens/navigation.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({Key? key}) : super(key: key);

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final studentNameController = TextEditingController();
  final emailController = TextEditingController();
  final domainNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final imagePicker = ImagePicker();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ScreenHome()),
                (route) => false);
          },
          icon: const Icon(
            (Icons.close),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (() {
                pickImage();
              }),
              child: imageProfile(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 209, 207, 207),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                    child: ListView(
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: studentNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 200, 198, 198),
                                    labelText: 'Student Name'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 200, 198, 198),
                                    labelText: 'E-mail'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: domainNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 200, 198, 198),
                                    labelText: 'Domain Name'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: contactNumberController,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 10) {
                                    return 'Mobile Number must be of 10 digit';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 200, 198, 198),
                                    labelText: ' Contact Number'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    addstudentButton();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenHome(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 2),
                                            content:
                                                Text('Successfully Added')));
                                  }
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Add Student'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _image = '';
  String imageToString = '';

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();

      setState(() {
        imageToString = base64Encode(imageTemporary);
        _image = imageToString;
      });
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: MemoryImage(const Base64Decoder().convert(_image)),
          ),
          const Positioned(
            bottom: 10,
            right: 10,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Future<void> addstudentButton() async {
    final studentName = studentNameController.text.trim();
    final studentEmail = emailController.text.trim();
    final studentDomain = domainNameController.text.trim();
    final studentContact = contactNumberController.text.trim();
    if (studentName.isEmpty ||
        studentEmail.isEmpty ||
        studentDomain.isEmpty ||
        studentContact.isEmpty) {
      return;
    } else {
      final students = StudentModel(
        name: studentName,
        email: studentEmail,
        domainName: studentDomain,
        contactNumber: studentContact,
        image: _image,
      );

      addStudent(students);
    }
  }
}
