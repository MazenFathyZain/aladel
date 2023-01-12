import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran_karim/model/event.dart';

import 'package:table_calendar/table_calendar.dart';

import '../services/auth.dart';
import '../services/firestore_user.dart';
import 'custom_widgets/drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

Map<DateTime, List<Event>>? selectedEvents;
CalendarFormat format = CalendarFormat.month;
DateTime _selectedDay = DateTime.now();
int date = DateTime.now().day;
DateTime _focusDay = DateTime.now();

final controller = Get.put(Auth());
final controller2 = Get.put(FirestoreUser());

//   TextEditingController _eventController = TextEditingController();
class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: DrawerView(),
      appBar: AppBar(
        backgroundColor: Color(0xff0074af),
        title: Text("مسجد العادل"),
        actions: [],
      ),
      // .where("time", isEqualTo: _selectedDay)
      body: StreamBuilder<QuerySnapshot>(
        stream: controller2.userCollectionRef
            .doc(controller.user)
            .collection("data")
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.requireData.size == 0) {
              return Center(
                  child: Column(
                children: [
                  Image.asset(
                    "images/noo.png",
                    width: width * 70 / 100,
                    height: height * 80 / 100,
                  ),
                ],
              ));
            } else {
              final data = snapshot.requireData;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                            child: Center(
                              child: Container(
                                width: width * 95 / 100,
                                // height: height * 20 / 100,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    // #################################################### التارخ
                                    Container(
                                      width: width,
                                      height: height * 6 / 100,
                                      child: Center(
                                          child: Text(
                                        formattedDate(
                                            snapshot.data!.docs[index]["time"]),
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                        ),
                                        color: Color(0xfff9b600),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: width * 65 / 100,
                                              height: height * 7 / 100,
                                              child: Center(
                                                  child: Text(
                                                      snapshot.data!.docs[index]
                                                          ["save_grade"])),
                                            ),
                                            Container(
                                              color: Color(0xff0074af),
                                              width: width * 30 / 100,
                                              height: height * 7 / 100,
                                              child: const Center(
                                                  child: Text(
                                                "تقييم الحفظ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: width * 65 / 100,
                                              height: height * 7 / 100,
                                              child: Center(
                                                  child: Text(
                                                      snapshot.data!.docs[index]
                                                          ["revision_grade"])),
                                            ),
                                            Container(
                                              color: Color(0xff0074af),
                                              width: width * 30 / 100,
                                              height: height * 7 / 100,
                                              child: const Center(
                                                  child: Text(
                                                "تقييم المراجعه",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: width * 65 / 100,
                                              height: height * 7 / 100,
                                              child: Center(
                                                child: Text(
                                                    "${snapshot.data!.docs[index]["from_surah_save"]} ${snapshot.data!.docs[index]["from_aya_save"]} - ${snapshot.data!.docs[index]["to_surah_save"]} ${snapshot.data!.docs[index]["to_aya_save"]}"),
                                              ),
                                            ),
                                            Container(
                                              color: Color(0xff0074af),
                                              width: width * 30 / 100,
                                              height: height * 7 / 100,
                                              child: const Center(
                                                child: Text(
                                                  "واجب الحفظ",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: width * 65 / 100,
                                              height: height * 7 / 100,
                                              child: Center(
                                                child: Text(
                                                    "${snapshot.data!.docs[index]["from_surah_revision"]} ${snapshot.data!.docs[index]["from_aya_revision"]} - ${snapshot.data!.docs[index]["to_surah_revision"]} ${snapshot.data!.docs[index]["to_aya_revision"]}"),
                                              ),
                                            ),
                                            Container(
                                              color: Color(0xff0074af),
                                              width: width * 30 / 100,
                                              height: height * 7 / 100,
                                              child: const Center(
                                                  child: Text(
                                                "واجب المراجعه",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: width * 65 / 100,
                                              height: height * 7 / 100,
                                              child: Center(
                                                child: Text(
                                                    snapshot.data!.docs[index]["notes"].toString()),
                                              ),
                                            ),
                                            Container(
                                              color: Color(0xff0074af),
                                              width: width * 30 / 100,
                                              height: height * 7 / 100,
                                              child: const Center(
                                                  child: Text(
                                                "ملاحظات الشيخ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 2),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Text("");
        },
      ),
    );
  }

  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat("EEEE, yyyy-MM-dd").format(dateFromTimeStamp);
  }
}
