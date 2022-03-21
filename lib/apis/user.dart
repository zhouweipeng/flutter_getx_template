part of apis;

/// 用户相关
class UserAPI {
  /// 登录
  static Future<UserLoginResponseData> login(
      UserLoginRequestParams params) async {
    final response = await HttpUtil()
        .get('/auth/oauth/token', queryParameters: params.toJson());
    return UserLoginResponseData.fromJson(response);
  }

  /// 根据token重新获取用户信息
  static Future<UserLoginResponseData> getUserInfoByToken() async {
    final response = await HttpUtil().post('/auth/oauth/getUserInfo');
    return UserLoginResponseData.fromJson(response);
  }

  /// 刷新token
  static Future<UserLoginResponseData> refreshUserInfo(
      UserRefreshRequestParams params) async {
    final response = await HttpUtil()
        .get('/auth/oauth/token', queryParameters: params.toJson());
    return UserLoginResponseData.fromJson(response);
  }

  /// 退出登录
  static Future logout() async {
    return await HttpUtil().post('/auth/oauth/logout');
  }
}
