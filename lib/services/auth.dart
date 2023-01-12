import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quran_karim/model/data.dart';
import 'package:quran_karim/view/home_view.dart';

import '../constants.dart';
import '../model/student_model.dart';
import '../view/profile_view.dart';
import 'firestore_user.dart';

class Auth extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email,
      password,
      name,
      school_name,
      teacher_name,
      mobile,
      phone,
      age,
      image,
      city,
      academic_year,
      academic_type,
      from,
      to;

  final Rx<User?> _user = Rxn<User>();

  String? get user => _user.value?.uid;

  String? get user_email => _user.value?.email;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    getUserById();
  }

  final userRef = FirebaseFirestore.instance.collection(STUDENT_COLLECTION);

  getUserById() {
    userRef.doc(user).get().then((DocumentSnapshot doc) {
      print(doc.data());
      print(doc.id);
      print(doc.exists);
    });
  }

  getCurrentUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }

  void logout() async {
    _auth.signOut();
    if (user == null) {
      // Get.offAll(Login());
    }
  }

  void login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) => print(value));
      Get.offAll(HomeView());
    } on FirebaseException catch (e) {
      print(e.message);
      Get.snackbar(
        'Error login account',
        e.message.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) async {
        saveUser(user);
        Get.offAll(HomeView());
      });
    } on FirebaseException catch (e) {
      print(e.message);
      Get.snackbar(
        'Error login account',
        e.message.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveUser(UserCredential user) async {
    await FirestoreUser().addUserToFireStore(
      StudentModel(
        student_id: user.user!.uid,
        email: user.user!.email,
        name: name == null ? user.user!.displayName : name,
        image: image,
        mobile: mobile,
        school_name: school_name,
        age: age,
        // teacher_name: teacher_name,
        academic_Type: academic_type,
        academic_year: academic_year,
        city: city,
        from: from,
        to: to,
        phone: phone,
      ),
    );
  }

  String? from_surah;
  String? to_surah;
  String? grade;
  String? from_aya;
  String? to_aya;

  void saveData(
    DateTime? time,
  ) async {
    FirestoreUser().subCollection(
      user,
      Data(
        from_surah: from_surah,
        to_surah: to_surah,
        from_aya: from_aya,
        to_aya: to_aya,
        grade: grade,
        time: time,
      ),
    );
  }
}
