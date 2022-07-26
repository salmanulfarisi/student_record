import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/screens/detailsupdate.dart';

// ignore: must_be_immutable
class ScreenStudentDetails extends StatelessWidget {
  StudentModel data;
  int? index;
  final name = TextEditingController();
  final email = TextEditingController();
  final domain = TextEditingController();
  final contactNumber = TextEditingController();

  ScreenStudentDetails({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    name.text = data.name.toString();
    email.text = data.email.toString();
    domain.text = data.domainName.toString();
    contactNumber.text = data.contactNumber.toString();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Student Details'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenDetailsUpdate(
                          data: data,
                          index: index,
                        )));
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(data.image),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 209, 207, 207),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                      child: Column(
                        children: [
                          TextField(
                            controller: name,
                            readOnly: true,
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
                          TextField(
                            controller: email,
                            readOnly: true,
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
                          TextField(
                            controller: domain,
                            readOnly: true,
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
                          TextField(
                            controller: contactNumber,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
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
        ));
  }
}
