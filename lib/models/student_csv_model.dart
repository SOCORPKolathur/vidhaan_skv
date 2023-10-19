class StudentModelForCsv {
  String? name;
  String? lastName;
  String? applicationNumber;
  String? academicYear;
  String? clasS;
  String? section;
  String? email;
  String? phone;
  String? house;
  String? dob;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? community;
  String? aadhaarNumber;
  String? height;
  String? weight;
  String? emiNo;
  String? identificationMark;
  String? modeOfTransport;
  String? address;
  String? fatherName;
  String? fatherEmail;
  String? fatherOccupation;
  String? fatherPhone;
  String? fatherAadhaar;
  String? fatherOfficeAddress;
  String? motherName;
  String? motherEmail;
  String? motherOffice;
  String? motherOccupation;
  String? motherPhone;
  String? motherAadhaar;
  String? guardianName;
  String? guardianOccupation;
  String? guardianPhone;
  String? guardianEmail;
  String? guardianAadhaar;
  String? brotherStudyingHere;
  String? brotherName;

  StudentModelForCsv(
      {this.name,
        this.lastName,
        this.applicationNumber,
        this.academicYear,
        this.clasS,
        this.section,
        this.email,
        this.phone,
        this.house,
        this.dob,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.community,
        this.aadhaarNumber,
        this.height,
        this.weight,
        this.emiNo,
        this.identificationMark,
        this.modeOfTransport,
        this.address,
        this.fatherName,
        this.fatherEmail,
        this.fatherOccupation,
        this.fatherPhone,
        this.fatherAadhaar,
        this.fatherOfficeAddress,
        this.motherName,
        this.motherEmail,
        this.motherOffice,
        this.motherOccupation,
        this.motherPhone,
        this.motherAadhaar,
        this.guardianName,
        this.guardianOccupation,
        this.guardianPhone,
        this.guardianEmail,
        this.guardianAadhaar,
        this.brotherStudyingHere,
        this.brotherName,
      });

  StudentModelForCsv.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    applicationNumber = json['applicationNumber'];
    academicYear = json['academicYear'];
    clasS = json['clasS'];
    section = json['section'];
    email = json['email'];
    phone = json['phone'];
    house = json['house'];
    dob = json['dob'];
    gender = json['gender'];
    bloodGroup = json['bloodGroup'];
    religion = json['religion'];
    community = json['community'];
    aadhaarNumber = json['aadhaarNumber'];
    height = json['height'];
    weight = json['weight'];
    emiNo = json['emiNo'];
    identificationMark = json['identificationMark'];
    modeOfTransport = json['modeOfTransport'];
    address = json['address'];
    fatherName = json['fatherName'];
    fatherEmail = json['fatherEmail'];
    fatherOccupation = json['fatherOccupation'];
    fatherPhone = json['fatherPhone'];
    fatherAadhaar = json['fatherAadhaar'];
    fatherOfficeAddress = json['fatherOfficeAddress'];
    motherName = json['motherName'];
    motherEmail = json['motherEmail'];
    motherOffice = json['motherOffice'];
    motherOccupation = json['motherOccupation'];
    motherPhone = json['motherPhone'];
    motherAadhaar = json['motherAadhaar'];
    guardianName = json['guardianName'];
    guardianOccupation = json['guardianOccupation'];
    guardianPhone = json['guardianPhone'];
    guardianEmail = json['guardianEmail'];
    guardianAadhaar = json['guardianAadhaar'];
    brotherStudyingHere = json['brotherStudyingHere'];
    brotherName = json['brotherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['applicationNumber'] = this.applicationNumber;
    data['academicYear'] = this.academicYear;
    data['clasS'] = this.clasS;
    data['section'] = this.section;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['house'] = this.house;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['bloodGroup'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['community'] = this.community;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['emiNo'] = this.emiNo;
    data['identificationMark'] = this.identificationMark;
    data['modeOfTransport'] = this.modeOfTransport;
    data['address'] = this.address;
    data['fatherName'] = this.fatherName;
    data['fatherEmail'] = this.fatherEmail;
    data['fatherOccupation'] = this.fatherOccupation;
    data['fatherPhone'] = this.fatherPhone;
    data['fatherAadhaar'] = this.fatherAadhaar;
    data['fatherOfficeAddress'] = this.fatherOfficeAddress;
    data['motherName'] = this.motherName;
    data['motherEmail'] = this.motherEmail;
    data['motherOffice'] = this.motherOffice;
    data['motherOccupation'] = this.motherOccupation;
    data['motherPhone'] = this.motherPhone;
    data['motherAadhaar'] = this.motherAadhaar;
    data['guardianName'] = this.guardianName;
    data['guardianOccupation'] = this.guardianOccupation;
    data['guardianPhone'] = this.guardianPhone;
    data['guardianEmail'] = this.guardianEmail;
    data['guardianAadhaar'] = this.guardianAadhaar;
    data['brotherStudyingHere'] = this.brotherStudyingHere;
    data['brotherName'] = this.brotherName;
    return data;
  }
}
