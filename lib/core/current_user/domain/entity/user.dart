class User {
  final String id;
  final String fullName;
  final String email;
  final String birthDate;
  final String gender;
  final int age;
  final String role;
  final String phoneNumber;
  final String? token;
  final String? profileImage;
  final String? generalSummary;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.age,
    required this.role,
    required this.phoneNumber,
    this.profileImage,
    this.token,
    this.generalSummary,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? birthDate,
    String? gender,
    int? age,
    String? role,
    String? phoneNumber,
    String? token,
    String? profileImage,
    String? generalSummary,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
      profileImage: profileImage ?? this.profileImage,
      generalSummary: generalSummary?? this.generalSummary,
    );
  }

  bool get isLoggedIn => token != null && token!.isNotEmpty;
}
