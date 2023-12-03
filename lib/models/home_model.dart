class HomeDetails {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final int siteId;
  final int shiftId;
  final int securityGuardId;

  HomeDetails({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.siteId,
    required this.shiftId,
    required this.securityGuardId,
  });

  factory HomeDetails.fromJson(Map<String, dynamic> json) {
    return HomeDetails(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      siteId: json['siteId'] ?? 0,
      shiftId: json['shiftId'] ?? 0,
      securityGuardId: json['securityGuardId'] ?? 0,
    );
  }
}
