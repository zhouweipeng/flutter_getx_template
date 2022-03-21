part of middlewares;

/// 检查是否登录
class AuthRouteMiddleware extends GetMiddleware {
  @override
  final int priority;

  AuthRouteMiddleware({this.priority = 0});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.instance.isLogin ||
        route == AppRoutes.sign_in ||
        route == AppRoutes.sign_up ||
        route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(
          Duration(seconds: 1), () => Get.snackbar('提示', '登录过期,请重新登录'));
      return RouteSettings(name: AppRoutes.sign_in);
    }
  }
}
