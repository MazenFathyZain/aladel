import 'dart:io';

class StudentModel {
  String? student_id;
  String? name;
  String? email;
  // String? teacher_name;
  String? school_name;
  String? image;
  String? mobile;
  String? phone;
  String? age;
  String? city;
  String? academic_year;
  String? academic_Type;
  String? from;
  String? to;

  StudentModel({
    this.student_id,
    this.name,
    this.email,
    // this.teacher_name,
    this.school_name,
    this.image,
    this.mobile,
    this.age,
    this.city,
    this.academic_year,
    this.academic_Type,
    this.from,
    this.to,
    this.phone,
  });

  StudentModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    } else {
      student_id = map["student_id"];
      name = map["name"];
      email = map["email"];
      // teacher_name = map["teacher_name"];
      school_name = map["school_name"];
      image = map["image"];
      mobile = map["mobile"];
      phone = map["phone"];
      age = map["age"];
      city = map["city"];
      academic_year = map["academic_year"];
      academic_Type = map["academic_Type"];
      from = map["from"];
      to = map["to"];
    }
  }

  toJson() {
    return {
      "student_id": student_id,
      "name": name,
      "email": email,
      // "teacher_name": teacher_name,
      "school_name": school_name,
      "image": image,
      "mobile": mobile,
      "phone": phone,
      "age": age,
      "city": city,
      "academic_year": academic_year,
      "academic_Type": academic_Type,
      "from": from,
      "to": to,
    };
  }
}
