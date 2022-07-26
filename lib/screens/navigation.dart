import 'package:flutter/material.dart';
import 'package:student_record/screens/add.dart';
import 'package:student_record/screens/home1.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int selectIndex = 0;
  final newPages = [
    const ScreenStudendList(),
    const ScreenAdd(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newPages[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (newIndex) {
          setState(() {
            selectIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Student',
          ),
        ],
      ),
    );
  }
}
