class UserModel {
  final String fname;
  final String lname;
  final String email;
  final String phoneNumber;
  final String birthdate;

  UserModel({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNumber,
    required this.birthdate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json["fname"],
      lname: json["lname"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      birthdate: json["birthdate"],
    );
  }

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "email": email,
    "phone_number": phoneNumber,
    "birthdate": birthdate,
  };
}
