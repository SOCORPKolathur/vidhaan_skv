class AttendancePdfModel {
  String? name;
  bool? attendance;
  String? id;
  String? date;
  String? clasS;

  AttendancePdfModel({this.name, this.attendance, this.id, this.date, this.clasS});

  AttendancePdfModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    attendance = json['attendance'];
    id = json['id'];
    date = json['date'];
    clasS = json['clasS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['attendance'] = this.attendance;
    data['id'] = this.id;
    data['date'] = this.date;
    data['clasS'] = this.clasS;
    return data;
  }

  String getIndex(int index,int row) {
    switch (index) {
      case 0:
        return (row + 1).toString();
      case 1:
        return id!;
      case 2:
        return name!;
      case 3:
        return attendance! ? "Present" : "Absent";
    }
    return '';
  }
}
