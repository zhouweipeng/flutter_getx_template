### flutter_getx_template

flutter&getx 开发模板，基于[ducafecat 的 flutter&getx 模板](https://github.com/ducafecat/flutter_ducafecat_news_getx)进行修改

文件说明

```
|--android
|--ios
|--assets
|--lib
   |--apis 接口请求方法
   |--models 数据模型
   |--config 配置数据或全局值
   |--routes 路由
      |--middlewares 路由中间件（相当于是手动对某些页面生效的路由守卫）
      |--names.dart 定义路由名
      |--observer.dart 监听路由跳转
      |--pages.dart 路由表
      |--routes.dart 入口
   |--store 仓库
   |--utils 通用工具类
   |--langs 国际化（非必要时可删除）
   |--services (GetxService和GetxController的区别是service存在于应用的整个生命周期)
   |--style 全局样式定义
   |--widgets 通用组件
   |--pages
      |--frame 通用页面
         |--not_found 无数据
            |--内部格式同普通页面
         |--sign_in 登录
         |--sign_on 注册
         |--welcome 欢迎页
      |--tabbar tabbar页面
         |--tab_page1
         |--tab_page2
         |--tab_page3
	  |--home 应用首页（首页一般来说就是引用tabbar的那个页面）
	     |--widgets 页面拆分的组件
         |--state.dart
         |--view.dart
         |--binding.dart
         |--controller.dart
         |--index.dart
	  |--其他页面
	     |--widgets 页面拆分的组件
		 |--state.dart
		 |--view.dart
		 |--binding.dart
		 |--controller.dart
		 |--index.dart
   |--generated_plugin_registrant.dart 运行到web端自动生成的文件（非必要时可删除）
   |--global.dart 全局定义服务定义或状态栏样式设置
   |--main.dart 主入口
```
