class SecurityGuardDetails {
  final int id;
  final int companyId;
  final String gender;
  final String uniqueId;
  final String dateOfBirth;
  final bool armedStatus;
  final int deployedSiteId;
  final int shiftId;
  final String username;
  final String firstName;
  final String lastName;
  final String role;
  final String phoneNumber;

  SecurityGuardDetails({
    required this.id,
    required this.companyId,
    required this.gender,
    required this.uniqueId,
    required this.dateOfBirth,
    required this.armedStatus,
    required this.deployedSiteId,
    required this.shiftId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.phoneNumber,
  });

  factory SecurityGuardDetails.fromJson(Map<String, dynamic> json) {
    return SecurityGuardDetails(
      id: json['id'] ?? 0,
      companyId: json['companyId'] ?? 0,
      gender: json['gender'] ?? "",
      uniqueId: json['uniqueId'] ?? "",
      dateOfBirth: json['dateOfBirth'] ?? "",
      armedStatus: json['armedStatus'] ?? false,
      deployedSiteId: json['deployedSiteId'] ?? 0,
      shiftId: json['shiftId'] ?? 0,
      username: json['username'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      role: json['role'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}
