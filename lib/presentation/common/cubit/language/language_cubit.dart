import 'package:smart_assistant_app/core/usecases/common/cache_language_locale.dart';
import 'package:smart_assistant_app/core/usecases/common/get_language_locale.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

enum LocaleLanguage { ar, en }

@injectable
class LanguageCubit extends Cubit<LocaleLanguage> {
  final GetLanguageLocale _getLanguageLocale;
  final CacheLanguageLocale _cacheLanguageLocale;

  LanguageCubit(this._getLanguageLocale, this._cacheLanguageLocale) : super(LocaleLanguage.en);
  bool get isArabic => state == LocaleLanguage.ar;

  setLanguage() {
    Future.delayed(Duration.zero, () async {
      final resEither = _getLanguageLocale(NoParams());
      resEither.fold((l) => null, (ll) {
        LocaleSettings.setLocaleRaw(ll.name);
        emit(ll);
      });
    });
  }

  toggleLanguage() {
    if (isArabic) {
      emit(LocaleLanguage.en);
    } else {
      emit(LocaleLanguage.ar);
    }
    LocaleSettings.setLocaleRaw(state.name);
    _cacheLanguageLocale(state);
  }
}
