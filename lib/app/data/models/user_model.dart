class IdentityData {
  final String avatarUrl;
  final String email;
  final bool emailVerified;
  final String fullName;
  final String iss;
  final String name;
  final bool phoneVerified;
  final String picture;
  final String providerId;
  final String sub;

  IdentityData({
    required this.avatarUrl,
    required this.email,
    required this.emailVerified,
    required this.fullName,
    required this.iss,
    required this.name,
    required this.phoneVerified,
    required this.picture,
    required this.providerId,
    required this.sub,
  });

  factory IdentityData.fromJson(Map<String, dynamic> json) {
    return IdentityData(
      avatarUrl: json["avatar_url"] ?? "",
      email: json["email"] ?? "",
      emailVerified: json["email_verified"] ?? false,
      fullName: json["full_name"] ?? "",
      iss: json["iss"] ?? "",
      name: json["name"] ?? "",
      phoneVerified: json["phone_verified"] ?? false,
      picture: json["picture"] ?? "",
      providerId: json["provider_id"].toString(),
      sub: json["sub"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "avatar_url": avatarUrl,
      "email": email,
      "email_verified": emailVerified,
      "full_name": fullName,
      "iss": iss,
      "name": name,
      "phone_verified": phoneVerified,
      "picture": picture,
      "provider_id": providerId,
      "sub": sub,
    };
  }
}

class UserIdentity {
  final String id;
  final String userId;
  final IdentityData identityData;
  final String identityId;
  final String provider;
  final DateTime createdAt;
  final DateTime lastSignInAt;
  final DateTime updatedAt;

  UserIdentity({
    required this.id,
    required this.userId,
    required this.identityData,
    required this.identityId,
    required this.provider,
    required this.createdAt,
    required this.lastSignInAt,
    required this.updatedAt,
  });

  factory UserIdentity.fromJson(Map<String, dynamic> json) {
  return UserIdentity(
    id: json["id"] ?? "",
    userId: json["user_id"] ?? "",
    identityData: IdentityData.fromJson(json["identity_data"] ?? {}),
    identityId: json["identity_id"] ?? "",
    provider: json["provider"] ?? "",
    createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
    lastSignInAt: DateTime.tryParse(json["last_sign_in_at"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
  );
}


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "identity_data": identityData.toJson(),
      "identityId": identityId,
      "provider": provider,
      "created_at": createdAt.toIso8601String(),
      "last_sign_in_at": lastSignInAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}

class SupabaseUser {
  final String id;
  final Map<String, dynamic> appMetadata;
  final Map<String, dynamic> userMetadata;
  final String email;
  final String? phone;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? emailConfirmedAt;
  final DateTime? lastSignInAt;
  final String role;
  final DateTime updatedAt;
  final List<UserIdentity> identities;
  final bool isAnonymous;

  SupabaseUser({
    required this.id,
    required this.appMetadata,
    required this.userMetadata,
    required this.email,
    this.phone,
    required this.createdAt,
    this.confirmedAt,
    this.emailConfirmedAt,
    this.lastSignInAt,
    required this.role,
    required this.updatedAt,
    required this.identities,
    required this.isAnonymous,
  });

  factory SupabaseUser.fromJson(Map<String, dynamic> json) {
  return SupabaseUser(
    id: json["id"] ?? "",
    appMetadata: json["app_metadata"] ?? {},
    userMetadata: json["user_metadata"] ?? {},
    email: json["email"] ?? "",
    phone: json["phone"],
    createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
    confirmedAt: json["confirmed_at"] != null
        ? DateTime.tryParse(json["confirmed_at"])
        : null,
    emailConfirmedAt: json["email_confirmed_at"] != null
        ? DateTime.tryParse(json["email_confirmed_at"])
        : null,
    lastSignInAt: json["last_sign_in_at"] != null
        ? DateTime.tryParse(json["last_sign_in_at"])
        : null,
    role: json["role"] ?? "",
    updatedAt: DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
    identities: (json["identities"] as List<dynamic>? ?? [])
        .map((e) => UserIdentity.fromJson(e))
        .toList(),
    isAnonymous: json["is_anonymous"] ?? false,
  );
}


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "app_metadata": appMetadata,
      "user_metadata": userMetadata,
      "email": email,
      "phone": phone,
      "created_at": createdAt.toIso8601String(),
      "confirmed_at": confirmedAt?.toIso8601String(),
      "email_confirmed_at": emailConfirmedAt?.toIso8601String(),
      "last_sign_in_at": lastSignInAt?.toIso8601String(),
      "role": role,
      "updated_at": updatedAt.toIso8601String(),
      "identities": identities.map((e) => e.toJson()).toList(),
      "is_anonymous": isAnonymous,
    };
  }
}
