class Data {
  String? from_surah, to_surah, grade, from_aya, to_aya;
  DateTime? time;

  Data({
    this.from_surah,
    this.to_surah,
    this.grade,
    this.from_aya,
    this.to_aya,
    this.time,
  });

  Data.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    } else {
      from_surah = map["from_surah"];
      to_surah = map["to_surah"];
      from_aya = map["from_aya"];
      to_aya = map["to_aya"];
      grade = map["grade"];
      time = map["time"];
    }
  }

  toJson() {
    return {
      "from_surah": from_surah,
      "to_surah": to_surah,
      "from_aya": from_aya,
      "to_aya": to_aya,
      "grade" : grade,
      "time": time,
    };
  }
}
