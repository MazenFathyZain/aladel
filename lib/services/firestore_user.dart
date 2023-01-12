import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran_karim/model/data.dart';
import 'package:quran_karim/model/student_model.dart';

import '../constants.dart';

class FirestoreUser {
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection(STUDENT_COLLECTION);

  Future<void> addUserToFireStore(StudentModel student) async {
    return await userCollectionRef
        .doc(student.student_id)
        .set(student.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<Future<DocumentReference<Map<String, dynamic>>>> subCollection(String? student_id,Data data)async{
    return userCollectionRef.doc(student_id).collection("data").add(data.toJson());
  }
}