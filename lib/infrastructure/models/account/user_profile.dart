import 'package:smart_assistant_app/infrastructure/models/account/profile_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: "_id") required String id,
    required String name,
    required String identification,
    required String address,
    required String phone,
    required String email,
    @JsonKey(name: "legal_form") String? legalForm,
    @JsonKey(name: "profile_type") required ProfileType type,
    @Default(ProfileSettings(
        activateAllNotifs: true, activateAuctionNotifs: true, activateBookmarkNotifs: true))
    ProfileSettings settings,
    required ProfileKind kind,
    required ProfileStatus status,
    @JsonKey(name: "files_urls") required List<String> attachments,
    @JsonKey(name: "rejection_reason") String? rejectionReason,
    @JsonKey(name: "accepted_at") DateTime? acceptedAt,
    @JsonKey(name: "rejected_at") DateTime? rejectedAt,
  }) = _UserProfile;
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

enum ProfileType {
  @JsonValue("PERSONAL")
  personal,
  @JsonValue("AFFILIATED")
  affiliated,
}

enum ProfileKind {
  @JsonValue("INDIVIDUAL")
  individual,
  @JsonValue("COMPANY")
  company,
}

enum ProfileStatus {
  @JsonValue("PENDING")
  pending,
  @JsonValue("ACCEPTED")
  accepted,
  @JsonValue("REJECTED ")
  rejected,
}
