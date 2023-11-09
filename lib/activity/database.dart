import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Create instance of add student in firebase
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc()
        .set(userInfoMap);
  }
}
