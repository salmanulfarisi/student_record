import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_record/screens/navigation.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Login Page',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Username";
                    } else if (value != 'salman') {
                      return 'Invalid Username';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Password";
                    } else if (value != '12345') {
                      return 'Incorrect Password';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Forget Password'),
        ),
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  checkLogin(context);
                }
              },
              child: const Text('Login'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dosenot have a Account?'),
            TextButton(onPressed: () {}, child: const Text('Sign in'))
          ],
        )
      ],
    ));
  }

  void checkLogin(BuildContext context) async {
    final userid = usernameController.text;
    final userpassword = passwordController.text;
    final username = userid;
    final password = userpassword;

    if (username == userid && password == userpassword) {
      final sharsprefs = await SharedPreferences.getInstance();
      await sharsprefs.setBool("SAVE_KEY", true);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context1) => const ScreenHome()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username and Password are not Matched'),
        ),
      );
    }
  }
}
