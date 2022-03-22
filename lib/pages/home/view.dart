import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_template/pages/tabbar/index.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );

  // 顶部导航
  AppBar _buildAppBar() => AppBar(title: Text('元亨利贞'));

  // 内容页
  Widget _buildPageView() => PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MainPage(),
          NotesPage(),
          Text('AccountPage'),
          Text('AccountPage')
        ],
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
      );

  // 底部导航
  Widget _buildBottomNavigationBar() => Obx(() => BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.state.page,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handleNavBarTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ));
}
