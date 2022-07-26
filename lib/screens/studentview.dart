import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_record/database/functions/db_functions.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/screens/search.dart';
import 'package:student_record/screens/studentsdetails.dart';

class ScreenStudentView extends StatelessWidget {
  const ScreenStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScreenSearch()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      MemoryImage(const Base64Decoder().convert(data.image)),
                ),
                title: Text(data.name),
                subtitle: const Text('Show more Details'),
                onTap: () {
                  print('object');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenStudentDetails(
                        data: data,
                        index: index,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    deleteStudent(index);
                    // if (data.id != null) {
                    //   deleteStudent(data.id!);
                    // } else {
                    //   print('object');
                    // }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        },
      ),
    );
  }
}
