import 'package:flutter_getx_template/models/models.dart';

class SignInState {
  final title = '欢迎登录';
  final subtitle = 'XXXX: XXXXXXXXXX';

  final defaultUserName = '123123123123';
  final defaultPassWord = '123456';

  final thirdPartyList = [
    ThirdPartyMode(id: 'weixin', name: '微信', icon: 'assets/images/weixin.png'),
    ThirdPartyMode(id: 'qq', name: 'QQ', icon: 'assets/images/qq.png'),
    ThirdPartyMode(id: 'weibo', name: '微博', icon: 'assets/images/weibo.png')
  ];

  final testUser = {
    'code': 200,
    'access_token': 'accessToken',
    'refresh_token': 'refreshToken',
    'msg': 'msg',
    'user': UserInfo(nickName: '测试角色', id: '1').toJson()
  };
}
