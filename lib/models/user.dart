part of models;

/// 登录请求
class UserLoginRequestParams {
  String username;
  String password;
  String clientId;
  String clientSecret;
  String scope;
  String grantType;

  UserLoginRequestParams(
      {required this.username,
        required this.password,
        this.clientId = CLIENT_ID,
        this.clientSecret = CLIENT_SECRET,
        this.scope = 'server',
        this.grantType = 'password'});

  factory UserLoginRequestParams.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestParams(
          username: json['username'],
          password: json['password'],
          clientId: json['client_id'],
          clientSecret: json['client_secret'],
          scope: json['scope'],
          grantType: json['grant_type']);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'client_id': clientId,
    'client_secret': clientSecret,
    'scope': scope,
    'grant_type': grantType
  };
}

/// 登录返回数据
class UserLoginResponseData {
  dynamic code;
  String? accessToken;
  String? refreshToken;
  String? msg;
  UserInfo? user;

  UserLoginResponseData(
      {required this.code,
        this.accessToken,
        this.refreshToken,
        this.msg,
        this.user});

  factory UserLoginResponseData.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseData(
          code: json['code'],
          accessToken: json['access_token'],
          refreshToken: json['refresh_token'],
          msg: json['msg'],
          user: json['user'] != null ? UserInfo.fromJson(json['user']) : null);

  Map<String, dynamic> toJson() => {
    'code': code,
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'msg': msg,
    'user': user?.toJson()
  };
}

/// 刷新token请求
class UserRefreshRequestParams {
  String refreshToken;
  String clientId;
  String clientSecret;
  String grantType;

  UserRefreshRequestParams(
      {required this.refreshToken,
        this.clientId = CLIENT_ID,
        this.clientSecret = CLIENT_SECRET,
        this.grantType = 'refresh_token'});

  factory UserRefreshRequestParams.fromJson(Map<String, dynamic> json) =>
      UserRefreshRequestParams(
          refreshToken: json['refresh_token'],
          clientId: json['client_id'],
          clientSecret: json['client_secret'],
          grantType: json['grant_type']);

  Map<String, dynamic> toJson() => {
    'refresh_token': refreshToken,
    'client_id': clientId,
    'client_secret': clientSecret,
    'grant_type': grantType
  };
}

/// 用户信息
class UserInfo {
  String id;
  String name;
  String nickName;
  String phone;
  String email;
  String username;
  String idCard;
  int sex;
  int education;
  int nation;
  bool activate;
  String? address;
  String? avatar;
  String? defaultEnterpriseId;
  String? defaultDepartmentId;
  String? defaultPostId;
  String? enterpriseIds;
  String? departmentIds;
  String? postIds;
  String? orgs;

  UserInfo(
      {this.id = '',
        this.name = '',
        this.nickName = '',
        this.phone = '',
        this.email = '',
        this.username = '',
        this.idCard = '',
        this.sex = 0,
        this.education = 0,
        this.nation = 0,
        this.activate = false,
        this.address,
        this.avatar,
        this.defaultEnterpriseId,
        this.defaultDepartmentId,
        this.defaultPostId,
        this.enterpriseIds,
        this.departmentIds,
        this.postIds,
        this.orgs});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'],
      name: json['name'],
      nickName: json['nickName'],
      phone: json['phone'],
      email: json['email'],
      username: json['username'],
      idCard: json['idCard'],
      sex: json['sex'],
      education: json['education'],
      nation: json['nation'],
      activate: json['activate'],
      address: json['address'],
      avatar: json['avatar'],
      defaultEnterpriseId: json['defaultEnterpriseId'],
      defaultDepartmentId: json['defaultDepartmentId'],
      defaultPostId: json['defaultPostId'],
      enterpriseIds: json['enterpriseIds'],
      departmentIds: json['departmentIds'],
      postIds: json['postIds'],
      orgs: json['orgs']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nickName': nickName,
    'phone': phone,
    'email': email,
    'username': username,
    'idCard': idCard,
    'sex': sex,
    'education': education,
    'nation': nation,
    'activate': activate,
    'address': address,
    'avatar': avatar,
    'defaultEnterpriseId': defaultEnterpriseId,
    'defaultDepartmentId': defaultDepartmentId,
    'defaultPostId': defaultPostId,
    'enterpriseIds': enterpriseIds,
    'departmentIds': departmentIds,
    'postIds': postIds,
    'orgs': orgs
  };
}

/// 第三方登录
class ThirdPartyMode {
  final String id;
  final String name;
  final String icon;

  ThirdPartyMode({required this.id, required this.name, required this.icon});

  factory ThirdPartyMode.fromJson(Map<String, dynamic> json) =>
      ThirdPartyMode(id: json['id'], name: json['name'], icon: json['icon']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'icon': icon};
}

