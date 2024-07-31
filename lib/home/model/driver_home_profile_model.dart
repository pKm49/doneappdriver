class GetDriverProfileDetails {
  final String name;
  final String code;
  final String image;
  final int totalOrders;
  final int deliveredOrders;
  final int pendingOrders;
  final List<Shift> shifts;

  GetDriverProfileDetails({
    required this.name,
    required this.code,
    required this.image,
    required this.totalOrders,
    required this.deliveredOrders,
    required this.pendingOrders,
    required this.shifts,
  });

  factory GetDriverProfileDetails.fromJson(Map<String, dynamic> json) =>
      GetDriverProfileDetails(
        name: json["name"],
        code: json["code"],
        image: json["image"],
        totalOrders: json["total_orders"],
        deliveredOrders: json["delivered_orders"],
        pendingOrders: json["pending_orders"],
        shifts: List<Shift>.from(json["shifts"].map((x) => Shift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "image": image,
        "total_orders": totalOrders,
        "delivered_orders": deliveredOrders,
        "pending_orders": pendingOrders,
        "shifts": List<dynamic>.from(shifts.map((x) => x.toJson())),
      };
}

class Shift {
  final int id;
  final String name;
  final String arabicName;

  Shift({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
      };
}
