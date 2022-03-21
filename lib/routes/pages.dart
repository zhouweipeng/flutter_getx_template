part of routes;

/// 路由
class AppPages {
  static const initial = AppRoutes.initial;
  static final RouteObserver<Route> observer = CustomRouteObserver();
  static List<String> history = [];

  /// 路由表
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        WelcomeRouteMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.sign_in,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.sign_up,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    // 需要登录
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [
        AuthRouteMiddleware(),
      ],
    ),
    // 编辑笔记（测试sqlite）
    GetPage(
      name: AppRoutes.edit,
      page: () => EditPage(),
      binding: EditBinding(),
    ),
  ];

  // static final unknownRoute = GetPage(
  //   name: AppRoutes.NotFound,
  //   page: () => NotFoundView(),
  // );
}
