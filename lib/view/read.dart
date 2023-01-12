import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quran_karim/services/auth.dart';

import '../model/student_model.dart';
import '../services/firestore_user.dart';

class Reading extends StatelessWidget {
   Reading({Key? key}) : super(key: key);
  final controller2 = Get.put(FirestoreUser());
  final controller = Get.put(Auth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مسجد العادل"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller2.userCollectionRef
            .doc(controller.user)
            .collection("data").orderBy("time")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                  Text(snapshot.data!.docs[index]["title"]),
                );
              },
            );
          }
          return Text("");
        },
      ),
    );
  }
}
