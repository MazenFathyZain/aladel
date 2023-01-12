// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:quran_karim/view/custom_widgets/custom_button.dart';
// import 'package:quran_karim/view/custom_widgets/custom_text_form_field.dart';
// import 'package:quran_karim/view/home_view.dart';
//
// import '../constants.dart';
// import '../services/auth.dart';
//
// class AddEvent extends StatelessWidget {
//   DateTime? date;
//
//   AddEvent({this.date});
//
//   Auth controller = Get.put(Auth());
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("مسجد العادل"),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   " : من سورة",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
//                 DropdownSearch<String>(
//                   mode: Mode.MENU,
//                   showSelectedItems: true,
//                   items: quran,
//                   dropdownSearchDecoration: InputDecoration(
//                     labelText: "اسم السورة",
//                   ),
//                   showSearchBox: true,
//                   onChanged: fromSurah,
//                   searchFieldProps: TextFieldProps(
//                     cursorColor: Colors.green,
//                   ),
//                 ),
//                 SizedBox(height: height * 1 / 100),
//                 Text(" : ايه رقم",
//                     style:
//                         TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                 CustomTextFormField(
//                   text: "",
//                   hint: "رقم الايه",
//                   keyboardType: TextInputType.number,
//                   onSave: (value) {
//                     controller.from_aya = value;
//                   },
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "required field";
//                     }
//                   },
//                 ),
//                 SizedBox(height: height * 1 / 100),
//                 Text(
//                   " : الى سورة",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
//                 DropdownSearch<String>(
//                   mode: Mode.MENU,
//                   showSelectedItems: true,
//                   items: quran,
//                   dropdownSearchDecoration: InputDecoration(
//                     labelText: "اسم السورة",
//                   ),
//                   showSearchBox: true,
//                   onChanged: toSurah,
//                   searchFieldProps: TextFieldProps(
//                     cursorColor: Colors.green,
//                   ),
//                 ),
//                 SizedBox(height: height * 1 / 100),
//                 Text(" : ايه رقم",
//                     style:
//                         TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                 CustomTextFormField(
//                   text: "",
//                   hint: "رقم الايه",
//                   keyboardType: TextInputType.number,
//                   onSave: (value) {
//                     controller.to_aya = value;
//                   },
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "required field";
//                     }
//                   },
//                 ),
//                 SizedBox(height: height * 1 / 100),
//                 DropdownSearch<String>(
//                   mode: Mode.MENU,
//                   showSelectedItems: true,
//                   items: grade,
//                   dropdownSearchDecoration: InputDecoration(
//                     labelText: "التقدير",
//                   ),
//                   showSearchBox: true,
//                   onChanged: grade_of_surah,
//                   searchFieldProps: TextFieldProps(
//                     cursorColor: Colors.green,
//                   ),
//                 ),
//                 SizedBox(height: height * 3 / 100),
//                 Container(
//                   width: width,
//                   child: CustomButton(
//                     text: "Done",
//                     onpressed: () {
//                       _formKey.currentState!.save();
//                       if (_formKey.currentState!.validate()) {
//                         controller.saveData(date);
//                       }
//                       Get.to(HomeView());
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void fromSurah(String? value) {
//     controller.from_surah = value;
//   }
//
//   void toSurah(String? value) {
//     controller.to_surah = value;
//   }
//
//   void grade_of_surah(String? value) {
//     controller.grade = value;
//   }
// }
