import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DatabaseMethods {
  Future addUserDetals(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserbyemail(String Email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: Email)
        .get();
  }
}
