import 'package:flutter/material.dart';
import 'package:myapp/homeScreen.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "loginPage";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool visible = false;
  final _userNameController = TextEditingController();
  final _passwordControler = TextEditingController();
  Future<void> checkLogin() async {
    final username = _userNameController.text;
    final password = _passwordControler.text;
    if (username == password) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(userKey, true);
      print(prefs);
      setState(() {
        visible = false;
      });
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  final snackBar = SnackBar(
    content: const Text('Invalid'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter something',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    )),
                controller: _userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter username";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter something',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    )),
                controller: _passwordControler,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: visible,
                child: Text("Usename/password not matched"),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkLogin();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(Icons.key),
                  label: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
