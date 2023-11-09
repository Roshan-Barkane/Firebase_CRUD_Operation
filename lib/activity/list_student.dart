import 'package:callenge_9/activity/updata_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({super.key});

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  // instance of firebase firestor
  final Stream<QuerySnapshot> StrudentStream =
      FirebaseFirestore.instance.collection('Students').snapshots();

  // delete data into fite base
  CollectionReference students =
      FirebaseFirestore.instance.collection('Students');
  Future<void> deleteUser(id) {
    return students.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: StrudentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // check the error
          if (snapshot.hasError) {
            print("Something when wrong !");
          }
          //check the waiting time how to tack fatch data into firebase
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // create the list store the all fatch data for firebase
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Container(
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ]),
                  // for loop used to show all the documents
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                          child: Center(
                        child: Text(
                          // how to fatch data into firedata fitestore database
                          storedocs[i]['name'],
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      )),
                      TableCell(
                          child: Center(
                        child: Text(
                          // how to fatch data into firedata fitestore database
                          storedocs[i]['email'],
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      )),
                      TableCell(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateStudent(id: storedocs[i]['id']),
                                    ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              )),
                          IconButton(
                              // call the delete user mather delete perticular id student
                              onPressed: () {
                                deleteUser(storedocs[i]['id']);
                                Fluttertoast.showToast(
                                    msg: "Delete Student Sucessfuly",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor:
                                        const Color.fromARGB(255, 91, 85, 85),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ))
                    ]),
                  ],
                ],
              ),
            ),
          );
        });
    /**/
  }
}
