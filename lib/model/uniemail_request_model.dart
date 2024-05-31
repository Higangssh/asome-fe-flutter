class VerifyEmailRequest {
  final String universityName;
  final String? email;
  final int? code;

  VerifyEmailRequest({
    required this.universityName,
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'universityName': universityName,
      'email': email,
      'code': code,
    };
  }

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) {
    return VerifyEmailRequest(
      universityName: json['universityName'],
      email: json['email'],
      code: json['code'],
    );
  }
}