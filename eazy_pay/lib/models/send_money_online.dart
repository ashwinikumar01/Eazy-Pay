import 'dart:convert';

SendMoneyOnline sendMoneyOnlineFromJson(String str) =>
    SendMoneyOnline.fromJson(json.decode(str));

String sendMoneyOnlineToJson(SendMoneyOnline data) =>
    json.encode(data.toJson());

class SendMoneyOnline {
  SendMoneyOnline({
    this.message,
    this.status,
  });

  String message;
  String status;

  factory SendMoneyOnline.fromJson(Map<String, dynamic> json) =>
      SendMoneyOnline(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
