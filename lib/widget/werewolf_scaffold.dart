import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_password/base/base_view.dart';
import 'package:remember_password/core.dart';
import '../color/colors.dart';

class MyScaffold extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? child;
  final Widget? leading;
  final Widget? body;
  final Color? appbarColor;
  final Widget? titleWidget;
  final Widget? floatingActionButton;
  final Brightness? brightness;
  final bool resizeToAvoidBottomInset;
  final bool showLeading;

   MyScaffold({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.brightness,
    this.body,
    this.appbarColor,
    this.resizeToAvoidBottomInset = false,
    this.child,
    this.titleWidget,
    this.floatingActionButton,
    this.showLeading = true
  }) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        //状态栏颜色
        brightness: brightness ?? Brightness.dark,
        centerTitle: true,
        backgroundColor: appbarColor??Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(title ?? '', style: TextStyle(fontSize: 36.sp, color: Colors.white, decoration: TextDecoration.none)),
        actions: actions,
        leading: leading??(showLeading?IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colours.white,), onPressed: () {
          Get.back();
        },
        ):null),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
