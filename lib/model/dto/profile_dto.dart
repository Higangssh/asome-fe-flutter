class ProfileResponseDto {
  final String nick;
  final String email;
  final String? universityEmail;
  final String? universityName;
  final String? profile;

  ProfileResponseDto({
    required this.nick,
    required this.email,
    required this.universityEmail,
    required this.universityName,
    required this.profile,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfileResponseDto(
      nick: json['nick'],
      email: json['email'],
      universityEmail: json['universityEmail'],
      universityName: json['universityName'],
      profile: json['profile'],
    );
  }
}
