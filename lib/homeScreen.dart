import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/login.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "homeScreen";

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dropdownValue;

  signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
  }

  Future<void> showBottomsheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    final _list = ["Apple", "moango", "orange"];
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text("title"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: Text("logout")),
              ElevatedButton(
                  onPressed: () {
                    showBottomsheet(context);
                  },
                  child: Text("data")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final _name = _usernameController.text.trim();
                        final _age = _password.text.trim();
                        if (_name.isEmpty || _age.isEmpty) {
                          return;
                        }
                        // print(_name + _age);
                        final ModelData _user =
                            ModelData(name: _name, age: _age);

                        addItemToList(_user);
                      },
                      child: Text('Add'))
                ],
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text(
                            itemlist[index].name,
                          ),
                          subtitle: Text(itemlist[index].age),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: itemlist.length))
            ],
          ),
        ),
      ),
    );
  }

  void addItemToList(ModelData _user) {
    setState(() {
      itemlist.add(_user);
      print(itemlist.length);
    });
  }
}

class ModelData {
  String name = "";
  String age = "";
  ModelData({required this.name, required this.age});
}

List<ModelData> itemlist = [
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12"),
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12"),
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12"),
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12"),
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12"),
  ModelData(name: "sarun", age: "33"),
  ModelData(name: 'karmi', age: "12")
];
