class SiteDetails {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String supervisorName;
  final String supervisorPhoneNumber;
  final String patrolPlanType;
  final int companyId;
  final List<Tag> tags;

  SiteDetails({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.supervisorName,
    required this.supervisorPhoneNumber,
    required this.patrolPlanType,
    required this.companyId,
    required this.tags,
  });

  factory SiteDetails.fromJson(Map<String, dynamic> json) {
    // Parse the tags list
    List<Tag> tags =
        (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList();

    return SiteDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? "",
      supervisorName: json['supervisorName'] ?? "",
      supervisorPhoneNumber: json['supervisorPhoneNumber'] ?? "",
      patrolPlanType: json['patrolPlanType'] ?? "",
      companyId: json['companyId'] ?? 0,
      tags: tags,
    );
  }
}

class Tag {
  final int id;
  final String uid;
  final int siteId;

  Tag({
    required this.id,
    required this.uid,
    required this.siteId,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? "",
      siteId: json['siteId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'siteId': siteId,
    };
  }
}
