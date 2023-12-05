import 'package:guard_tour/models/security_guard_model.dart';

class HomeDetails {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final int siteId;
  final int shiftId;
  final int securityGuardId;
  final Map<String, dynamic> securityGuard;

  HomeDetails({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.siteId,
    required this.shiftId,
    required this.securityGuardId,
    required this.securityGuard,
  });

  factory HomeDetails.fromJson(Map<String, dynamic> json) {
    return HomeDetails(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      siteId: json['site']['id'] ?? 0,
      shiftId: json['shiftId'] ?? 0,
      securityGuardId: json['securityGuard']['id'] ?? 0,
      securityGuard: json['securityGuard'],
    );
  }

  SecurityGuardDetails getSecurityGuardDetails() {
    return SecurityGuardDetails.fromJson(securityGuard);
  }
}
