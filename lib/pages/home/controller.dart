import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yhlz_flutter_template/style/style.dart';

import 'index.dart';

class HomeController extends GetxController {
  final state = HomeState();
  // tab 页标题
  late final List<String> tabTitles;
  // 页控制器
  late final PageController pageController;
  // 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['Welcome', 'Cagegory', 'Bookmarks', 'Account'];
    bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: AppColor.defaultColor,
        ),
        activeIcon: Icon(
          Iconfont.home,
          color: AppColor.activeColor,
        ),
        label: 'main',
        backgroundColor: AppColor.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Iconfont.grid,
          color: AppColor.defaultColor,
        ),
        activeIcon: Icon(
          Iconfont.grid,
          color: AppColor.activeColor,
        ),
        label: 'category',
        backgroundColor: AppColor.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Iconfont.tag,
          color: AppColor.defaultColor,
        ),
        activeIcon: Icon(
          Iconfont.tag,
          color: AppColor.activeColor,
        ),
        label: 'tag',
        backgroundColor: AppColor.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Iconfont.me,
          color: AppColor.defaultColor,
        ),
        activeIcon: Icon(
          Iconfont.me,
          color: AppColor.activeColor,
        ),
        label: 'my',
        backgroundColor: AppColor.primaryBackground,
      ),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }
}
