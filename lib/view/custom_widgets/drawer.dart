import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quran_karim/view/home_view.dart';

import '../../constants.dart';
import '../../services/auth.dart';
import '../../services/firestore_user.dart';
import '../add_event.dart';
import '../auth_view/login.dart';
import '../profile_view.dart';

class DrawerView extends StatelessWidget {
  DateTime _selectedDay = DateTime.now();
  int date = DateTime.now().day;
  DateTime _focusDay = DateTime.now();

  final controller = Get.put(Auth());
  final controller2 = Get.put(FirestoreUser());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: controller2.userCollectionRef
            .where("student_id", isEqualTo: controller.user)
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
                shrinkWrap: true,
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.30,
                        color: primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]["image"]),
                                radius:
                                    MediaQuery.of(context).size.width * 0.18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]["name"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]["email"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // body ################################################################
                      Container(
                        padding: EdgeInsets.only(top: 1.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.home,
                                color: primaryColor,
                              ),
                              title: Text(
                                "الصفحه الرئيسيه",
                                style: TextStyle(color: primaryColor),
                              ),
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (c) => HomeView());
                                Navigator.pushReplacement(context, route);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              title: Text(
                                "حسابي",
                                style: TextStyle(color: primaryColor),
                              ),
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (c) => ProfileView());
                                Navigator.push(context, route);
                              },
                            ),
                            // ListTile(
                            //   leading: Icon(
                            //     Icons.add_home_work_outlined,
                            //     color: primaryColor,
                            //   ),
                            //   title: Text(
                            //     "واجبات الطالب",
                            //     style: TextStyle(color: primaryColor),
                            //   ),
                            //   onTap: () {
                            //     Route route = MaterialPageRoute(
                            //         builder: (c) => ProfileView());
                            //     Navigator.push(context, route);
                            //   },
                            // ),
                            // Divider(height: 10.0,color: primaryColor,thickness: 1.0,),
                            ListTile(
                              leading: const Icon(Icons.contact_support_outlined,
                                  color: primaryColor),
                              title: const Text(
                                "تواصل معنا",
                                style: TextStyle(color: primaryColor),
                              ),
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('أرقام الإدارة'),
                                    content: const Text(
                                        'فضيلة الشيخ محمد عاطف : 01119081393\n المهندس احمد مصطفى : 01006759750 \n المهندس يحيى لقمان : 01115594090'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('حسنا'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout, color: primaryColor),
                              title: Text(
                                "تسجيل الخروج",
                                style: TextStyle(color: primaryColor),
                              ),
                              onTap: () {
                                final FirebaseAuth _auth =
                                    FirebaseAuth.instance;
                                _auth.signOut();
                                Get.offAll(Login());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }
          return Text("");
        },
      ),
    );
  }
}
