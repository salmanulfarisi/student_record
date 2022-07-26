import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/screens/navigation.dart';

class ScreenDetailsUpdate extends StatefulWidget {
  final StudentModel data;
  const ScreenDetailsUpdate({Key? key, required this.data, int? index})
      : super(key: key);

  @override
  State<ScreenDetailsUpdate> createState() => _ScreenDetailsUpdateState();
}

final studentsName = TextEditingController();
final studentsEmail = TextEditingController();
final studentsDomain = TextEditingController();
final studentsContactNumber = TextEditingController();

class _ScreenDetailsUpdateState extends State<ScreenDetailsUpdate> {
  @override
  Widget build(BuildContext context) {
    studentsName.text = widget.data.name.toString();
    studentsEmail.text = widget.data.email.toString();
    studentsDomain.text = widget.data.domainName.toString();
    studentsContactNumber.text = widget.data.contactNumber.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detaills Update'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: (() {
                  pickImage();
                }),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(
                      const Base64Decoder().convert(widget.data.image)),
                )),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
               
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
                        Column(
                          children: [
                            TextFormField(
                              controller: studentsName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: studentsEmail,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: studentsDomain,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: studentsContactNumber,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.data.name = studentsName.text;
                                  widget.data.email = studentsEmail.text;
                                  widget.data.domainName = studentsDomain.text;
                                  widget.data.contactNumber =
                                      studentsContactNumber.text;
                                  widget.data.image = widget.data.image;
                                  widget.data.save();
                                  checkValidation();
                                },
                                child: const Text('Update'),
                              ),
                            )
                          ],
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
        _image = imageToString;
        imageToString = base64Encode(imageTemporary);
      });
    }
  }

  Future<void> checkValidation() async {
    if (studentsName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Enter Name'),
        duration: Duration(seconds: 1),
      ));
    } else if (studentsEmail.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Enter Email'),
        duration: Duration(seconds: 1),
      ));
    } else if (studentsDomain.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Enter Domain Name'),
        duration: Duration(seconds: 1),
      ));
    } else if (studentsContactNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Enter Contact Number'),
        duration: Duration(seconds: 1),
      ));
    } else {
      widget.data.name = studentsName.text;
      widget.data.email = studentsEmail.text;
      widget.data.domainName = studentsDomain.text;
      widget.data.contactNumber = studentsContactNumber.text;
      widget.data.image = widget.data.image;
      widget.data.save();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScreenHome()),
          (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully Updated'),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
