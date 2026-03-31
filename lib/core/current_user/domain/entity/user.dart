class User {
  final String id;
  final String fullName;
  final String email;
  final String birthDate;
  final String gender;
  final int age;
  final String role;
  final String phoneNumber;
  final String token;
  final String? profileImage;
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
    required this.token,
  });

  User copyWith({
    final String? id,
    final String? fullName,
    final String? email,
    final String? birthDate,
    final String? gender,
    final int? age,
    final String? role,
    final String? phoneNumber,
    final String? token,
    final String? profileImage,
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
    );
  }

    bool get isLoggedIn => token.isNotEmpty;

}
