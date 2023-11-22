// site_profile_model.dart

class SiteProfile {
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

  SiteProfile({
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

  factory SiteProfile.fromJson(Map<String, dynamic> json) {
    // Parse tags from the JSON array
    List<Tag> tags =
        (json['tags'] as List).map((tagJson) => Tag.fromJson(tagJson)).toList();

    return SiteProfile(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phoneNumber: json['phoneNumber'],
      supervisorName: json['supervisorName'],
      supervisorPhoneNumber: json['supervisorPhoneNumber'],
      patrolPlanType: json['patrolPlanType'],
      companyId: json['companyId'],
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'supervisorName': supervisorName,
      'supervisorPhoneNumber': supervisorPhoneNumber,
      'patrolPlanType': patrolPlanType,
      'companyId': companyId,
      'tags': tags.map((tag) => tag.toJson()).toList(),
    };
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
      id: json['id'],
      uid: json['uid'],
      siteId: json['siteId'],
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
