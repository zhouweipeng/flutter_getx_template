part of store;

class UserStore extends GetxController {
  static UserStore get instance => Get.find();

  Map<String, String?> token = {'access_token': null, 'refresh_token': null};

  String? get accessToken => token['access_token'];

  String? get refreshToken => token['refresh_token'];

  bool get hasToken => token.values.every((e) => e != null && e.isNotEmpty);

  final _userInfo = UserInfo().obs;

  UserInfo get userInfo => _userInfo.value;

  bool get isLogin => userInfo.id.isNotEmpty;

  // 这是用来传给业务系统的用户信息
  String get userInfoToUnimp => jsonEncode({
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'user': userInfo.toJson()
  });

  @override
  void onInit() {
    super.onInit();
    // 从本地缓存中初始化token和用户信息
    final tokenCache = StorageService.instance.getString(STORAGE_TOKEN);
    if (tokenCache.isNotEmpty) token = Map.from(jsonDecode(tokenCache));
    final userInfoCache = StorageService.instance.getString(STORAGE_USER_INFO);
    if (userInfoCache.isNotEmpty)
      _userInfo(UserInfo.fromJson(jsonDecode(userInfoCache)));
  }

  // 获取用户信息
  Future<void> getUserInfo() async {
    // todo:
    // 当前内存是否存在用户信息，是就停止，否继续
    // 使用access_token获取用户信息，成功就停止，失败继续
    // 使用refresh_token刷新用户信息，成功就停止，失败跳回手动登录
  }

  // 保存用户信息
  Future<void> saveUserInfo(UserLoginResponseData loginRes) async {
    _userInfo(loginRes.user);
    token['access_token'] = loginRes.accessToken;
    token['refresh_token'] = loginRes.refreshToken;
    await StorageService.instance.setString(STORAGE_TOKEN, jsonEncode(token));
    await StorageService.instance
        .setString(STORAGE_USER_INFO, jsonEncode(loginRes.user));
  }

  // 注销
  Future<void> logout() async {
    if (isLogin) UserAPI.logout();
    await StorageService.instance.remove(STORAGE_TOKEN);
    await StorageService.instance.remove(STORAGE_USER_INFO);
    token.clear();
    _userInfo(UserInfo());
    Get.offAllNamed(AppRoutes.sign_in);
  }

  // 更新用户信息
  updateUserInfo(UserInfo userInfo) {
    _userInfo(userInfo);
  }
}