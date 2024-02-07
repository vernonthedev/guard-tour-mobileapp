class HomeDetails {
  final int id;
  final String date;
  final String startTime;
  final String securityGuardUniqueId;
  final String siteTagId;

  HomeDetails({
    required this.id,
    required this.date,
    required this.startTime,
    required this.securityGuardUniqueId,
    required this.siteTagId,
  });

  factory HomeDetails.fromJson(Map<String, dynamic> json) {
    return HomeDetails(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      securityGuardUniqueId: json['guardID'] ?? "",
      siteTagId: json['siteTagId'] ?? "",
    );
  }
}
