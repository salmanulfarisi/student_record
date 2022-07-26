import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_record/database/functions/db_functions.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/screens/studentsdetails.dart';

ValueNotifier<List<StudentModel>> temp = ValueNotifier([]);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (String? value) {
            if (value == null || value.isEmpty) {
              temp.value.addAll(studentListNotifier.value);
              temp.notifyListeners();
            } else {
              temp.value.clear();
              for (StudentModel item in studentListNotifier.value) {
                if (item.name.toLowerCase().contains(value.toLowerCase())) {
                  temp.value.add(item);
                }
                temp.notifyListeners();
              }
            }
          },
          controller: search,
        ),
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: temp,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenStudentDetails(
                          data: data,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: temp.value.length,
            );
          },
        ),
      ),
    );
  }
}
