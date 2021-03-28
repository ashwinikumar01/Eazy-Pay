import 'dart:convert';

SignupEmail signupEmailFromJson(String str) =>
    SignupEmail.fromJson(json.decode(str));

String signupEmailToJson(SignupEmail data) => json.encode(data.toJson());

class SignupEmail {
  SignupEmail({
    this.status,
    this.message,
    this.token,
  });

  String status;
  String message;
  String token;

  factory SignupEmail.fromJson(Map<String, dynamic> json) => SignupEmail(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
