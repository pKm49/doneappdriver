class DriverProfileModel {
  final String name;
  final String code;
  final String image;
  final String mobile;
  final String email;

  DriverProfileModel({
    required this.name,
    required this.code,
    required this.image,
    required this.mobile,
    required this.email,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileModel(
        name: json["name"],
        code: json["code"],
        image: json["image"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "image": image,
        "mobile": mobile,
        "email": email,
      };
}
