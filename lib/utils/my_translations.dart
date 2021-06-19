import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Todos',
        },
        'en_US': {
          'title': 'Todo s',
        }
      };
}
