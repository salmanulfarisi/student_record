import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_record/screens/login.dart';
import 'package:student_record/screens/studentview.dart';

class ScreenStudendList extends StatefulWidget {
  const ScreenStudendList({Key? key}) : super(key: key);

  @override
  State<ScreenStudendList> createState() => _ScreenStudendListState();
}

class _ScreenStudendListState extends State<ScreenStudendList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Salmanul Farisi'),
              accountEmail: Text('salmanfarisi0027@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/salman.jpeg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Signout'),
              onTap: () {
                signOut(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const ListTile(
              leading: Icon(Icons.mail),
              title: Text('Contact Us'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child:
                Image(image: AssetImage('assets/images/School_children.jpg')),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 135, 134, 134),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10),
                      child: SizedBox(
                        width: 370,
                        height: 100,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ScreenStudentView(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            child: ListView(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text('Students'),
                                    subtitle: Text('Details'),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/school no pic.webp',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }

  void signOut(BuildContext context) async {
    final sharesprefs = await SharedPreferences.getInstance();
    sharesprefs.clear();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
            child: AlertDialog(
              title: const Text('Signout'),
              content: const Text('Are you Sure?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (ctx) => const ScreenLogin(),
                        ),
                        (route) => false);
                  },
                  child: const Text('yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('no'),
                ),
              ],
            ),
          );
        });
  }
}
