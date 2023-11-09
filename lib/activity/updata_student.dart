import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateStudent extends StatefulWidget {
  final String id;
  UpdateStudent({super.key, required this.id});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  // updata data having textfields to firbase
  CollectionReference students =
      FirebaseFirestore.instance.collection('Students');
  Future<void> updataUser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'passowrd': password})
        .then((value) => print("Updata User Details"))
        .catchError((error) => print("Faild Student updata: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Updata Student"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        // get specific data by id in firebase
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print("Something when wrong !");
              }
              //check the waiting time how to tack fatch data into firebase
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['passowrd'];
              /*
              print("password is check : $name");
              print("password is check : $email");
              print("password is check : $password");*/
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        autofocus: false,
                        // Put the value of name
                        initialValue: name,
                        onChanged: (value) => name = value,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
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
                        // put the value of email
                        initialValue: email,
                        onChanged: (value) => email = value,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
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
                        // put the value of password
                        initialValue: password,

                        onChanged: (value) => password = value,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
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
                                  updataUser(widget.id, name, email, password);
                                  Fluttertoast.showToast(
                                      msg: "Updata Details Sucessfuly",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor:
                                          const Color.fromARGB(255, 91, 85, 85),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "Updata",
                                style: TextStyle(fontSize: 20.0),
                              )),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: Colors.blueGrey),
                            onPressed: () => {},
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
              );
            }),
      ),
    );
  }
}
