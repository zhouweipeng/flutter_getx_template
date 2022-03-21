part of style;

/// 配置主题
class AppTheme {
  static ThemeData common = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    // backgroundColor: AppColor.primaryBackground,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.appBarBackground,
      iconTheme: IconThemeData(
        color: AppColor.lightText,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.lightText,
        fontSize: Font.xl,
        fontWeight: FontWeight.w600,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColor.lightText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.bottomNavBackground,
        unselectedLabelStyle: TextStyle(fontSize: 10),
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedItemColor: AppColor.defaultColor,
        selectedItemColor: AppColor.activeColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColor.activeColor,
      unselectedLabelColor: AppColor.minorText,
    ),
  );
}
