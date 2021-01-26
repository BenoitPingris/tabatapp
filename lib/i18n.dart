import 'package:i18n_extension/i18n_extension.dart';
import 'package:i18n_extension/io/import.dart';

Future<void> loadTranslations() async {
  Localization._t = Translations.byLocale('en');
  Localization._t += await JSONImporter().fromAssetDirectory("assets/i18n");
}

extension Localization on String {
  static TranslationsByLocale _t;

  String get i18n => localize(this, _t);
}
