import 'package:smart_assistant_app/core/enums/deep_link.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_link_trigger.freezed.dart';

@freezed
class DeepLinkTrigger with _$DeepLinkTrigger {
  const factory DeepLinkTrigger({
    required DeepLinkTriggerType type,
    required String data,
    @Default([]) List<Map<String, String>> extra,
  }) = _DeepLinkTrigger;
}
