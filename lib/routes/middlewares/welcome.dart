part of middlewares;

/// 首次欢迎页
class WelcomeRouteMiddleware extends GetMiddleware {
  @override
  final int priority;

  WelcomeRouteMiddleware({this.priority = 0});

  @override
  RouteSettings? redirect(String? route) {
    if (!AppStore.instance.isNotFirstOpen) {
      return null;
    } else if (UserStore.instance.isLogin) {
      return RouteSettings(name: AppRoutes.home);
    } else {
      return RouteSettings(name: AppRoutes.sign_in);
    }
  }
}
