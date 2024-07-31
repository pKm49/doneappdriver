class OrderModel {
  final int id;
  final String image;
  final String name;
  final String arabicName;
  final String area;
  final String areaArabic;
  final String street;
  final String jedha;
  final String houseNumber;
  final String floorNumber;

  OrderModel({
    required this.id,
    required this.image,
    required this.name,
    required this.arabicName,
    required this.area,
    required this.areaArabic,
    required this.street,
    required this.jedha,
    required this.houseNumber,
    required this.floorNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        arabicName: json["arabic_name"],
        area: json["area"],
        areaArabic: json["area_arabic"],
        street: json["street"],
        jedha: json["jedha"],
        houseNumber: json["house_number"],
        floorNumber: json["floor_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "arabic_name": arabicName,
        "area": area,
        "area_arabic": areaArabic,
        "street": street,
        "jedha": jedha,
        "house_number": houseNumber,
        "floor_number": floorNumber,
      };
}
