import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remember_password/page/create_psw_page.dart';
import 'package:remember_password/page/main_page.dart';
import 'package:remember_password/page/gesture_password_page.dart';
import 'package:remember_password/page/setting_page.dart';
import 'package:remember_password/page/splash_page.dart';

class AppPages {

  static final List<GetPage> routes = [

    _getPage(
      name: '/',
      page: () =>  SplashPage(),
    ),
    _getPage(
      name: MainPage.routeName,
      page: () =>  MainPage(),
    ),
    _getPage(
      name: CreatePswPage.routeName,
      page: () =>  CreatePswPage(),
    ),
    _getPage(
      name: GesturePasswordPage.routeName,
      page: () =>  const GesturePasswordPage(),
    ),
    _getPage(
      name: SettingPage.routeName,
      page: () =>  SettingPage(),
    ),

  ];

  static GetPage _getPage({
    required String name,
    GetPageBuilder? page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      binding: binding,
      page: () {
        debugPrint('pageName=$name');
        return page!();
      },
      popGesture:name == MainPage.routeName || name == '/'?false:true
    );
  }
}

class CommonBinding<S> extends Bindings {
  final InstanceBuilderCallback<S> builder;

  CommonBinding(this.builder);

  @override
  void dependencies() {
    Get.lazyPut<S>(builder);
  }
}
