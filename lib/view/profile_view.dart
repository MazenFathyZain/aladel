import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quran_karim/view/auth_view/login.dart';
import 'package:quran_karim/view/custom_widgets/custom_container.dart';

import '../constants.dart';
import '../services/auth.dart';
import '../services/firestore_user.dart';
import 'custom_widgets/drawer.dart';

class ProfileView extends StatefulWidget {
  QueryDocumentSnapshot? model;

  ProfileView({this.model});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

final controller = Get.put(FirestoreUser());
final auth_controller = Get.put(Auth());

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: DrawerView(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "Profile page",
        ),
        actions: [
          TextButton(
            onPressed: () {
              _auth.signOut();
              Get.offAll(Login());
            },
            child: Text(
              "LogOut",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.userCollectionRef
            .where("student_id", isEqualTo: auth_controller.user)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  snapshot.data!.docs[index]["image"] == null ? Center(child: CircularProgressIndicator()) : snapshot.data!.docs[index]["image"]),
                              radius: width * 0.25,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "Name:",
                          title: snapshot.data!.docs[index]["name"],
                        ),

                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "Email:",
                          title: snapshot.data!.docs[index]["email"],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "Mobile Number:",
                          title: snapshot.data!.docs[index]["mobile"],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "Mobile Number 2:",
                          title: snapshot.data!.docs[index]["phone"],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "School:",
                          title: snapshot.data!.docs[index]["school_name"],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        // CustomContainer(
                        //   leading: "Teacher:",
                        //   title: snapshot.data!.docs[index]["teacher_name"],
                        // ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        CustomContainer(
                          leading: "Type:",
                          title: snapshot.data!.docs[index]["academic_Type"],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomContainer(
                          leading: "Academic year:",
                          title: snapshot.data!.docs[index]["academic_year"],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomContainer(
                          leading: "Age:",
                          title: snapshot.data!.docs[index]["age"],
                        ),
                        SizedBox(height: height * 0.02),
                        CustomContainer(
                          leading: "City:",
                          title: snapshot.data!.docs[index]["city"],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomContainer(
                                leading: "from:",
                                title: snapshot.data!.docs[index]["from"],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: CustomContainer(
                                leading: "To:",
                                title: snapshot.data!.docs[index]["to"],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
          return Text("");
        },
      ),
    );
  }
}
// Center(
// child: CircleAvatar(
// backgroundColor: Colors.white,
// backgroundImage: NetworkImage(snapshot.data!.docs[index]["image"]),
// // child: Image.network(data.docs[index]["image"]),
// radius: width * 0.20,
// ),
// );
