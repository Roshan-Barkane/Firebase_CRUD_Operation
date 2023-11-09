import 'package:callenge_9/activity/add_student.dart';
import 'package:callenge_9/activity/list_student.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Flutter with Firebase",
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddStudentPage(),
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black26),
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          )),
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "List of All Students.",
            style: TextStyle(fontSize: 20),
          ),
          ListStudentPage()
        ],
      ),
    );
  }
}
