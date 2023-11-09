import 'package:callenge_9/activity/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = " ";
  var email = " ";
  var password = " ";

  final nameControllar = TextEditingController();
  final emailControllar = TextEditingController();
  final passwordControllar = TextEditingController();

  @override
  void dispose() {
    nameControllar.dispose();
    emailControllar.dispose();
    passwordControllar.dispose();
    super.dispose();
  }

// add the student info into firebase database
  addUser() async {
    Map<String, dynamic> adduser = {
      'name': nameControllar.text,
      'email': emailControllar.text,
      'passowrd': passwordControllar.text,
    };
// show the massege add student sucessfully in firestore
    await DatabaseMethods().addUserDetails(adduser);
    Fluttertoast.showToast(
        msg: "Add Student Sucessfuly",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 91, 85, 85),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  clearText() {
    nameControllar.clear();
    emailControllar.clear();
    passwordControllar.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameControllar,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailControllar,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordControllar,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 40),
                            backgroundColor: Colors.black54),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              name = nameControllar.text;
                              email = emailControllar.text;
                              password = passwordControllar.text;
                              addUser();
                              clearText();
                            });
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 20.0),
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40),
                          backgroundColor: Colors.blueGrey),
                      onPressed: () => {clearText()},
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
