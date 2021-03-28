import 'dart:convert';

PhoneVerify phoneVerifyFromJson(String str) =>
    PhoneVerify.fromJson(json.decode(str));

String phoneVerifyToJson(PhoneVerify data) => json.encode(data.toJson());

class PhoneVerify {
  PhoneVerify({
    this.status,
    this.message,
    this.banks,
  });

  String status;
  String message;
  List<Bank> banks;

  factory PhoneVerify.fromJson(Map<String, dynamic> json) => PhoneVerify(
        status: json["status"],
        message: json["message"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
      };
}

class Bank {
  Bank({
    this.name,
    this.id,
  });

  String name;
  String id;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
