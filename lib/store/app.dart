part of store;

class AppStore extends GetxController {
  static AppStore get instance => Get.find();

  bool isNotFirstOpen = false;

  Locale locale = Locale('en', 'US');
  List<Locale> languages = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  // 是否是生产环境
  bool get isRelease => bool.fromEnvironment('dart.vm.product');

  @override
  void onInit() {
    super.onInit();
    isNotFirstOpen = StorageService.instance.getBool(STORAGE_NOT_FIRST_OPEN);
  }

  // 标记用户已打开APP
  Future<bool> saveAlreadyOpen() {
    return StorageService.instance.setBool(STORAGE_NOT_FIRST_OPEN, true);
  }

  void onInitLocale() {
    var langCode = StorageService.instance.getString(STORAGE_LANGUAGE_CODE);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.instance.setString(STORAGE_LANGUAGE_CODE, value.languageCode);
  }
}
