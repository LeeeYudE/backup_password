
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_password/color/colors.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/page/dialog/comfin_dialog.dart';

import '../language/strings.dart';


class GetxUtils{

  ///打开一个新路由，跟原生pushNamed一样效果
  static Future<T?>? pushNamed<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  ///清除之前的页面路由，并替换新的页面
  static Future<T?>? offAllNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, arguments: arguments);
  }

  ///删除当前路由，并替换新的页面
  static Future? offNamed(String routeName, {dynamic arguments}) {
    return Get.offNamed(routeName, arguments: arguments);
  }

  static void pop<T extends Object>([T? result]) {
    return Get.back(result: result);
  }

  static Future<T?> showCommonDialog<T>(

      Widget dialog, {
        bool barrierDismissible = false,
      }) {
    return Get.generalDialog<T>(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return dialog;
      },
    );
  }

  static Future<bool?> showConfimDialog(BuildContext context,String title) {
   return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(Ids.tips.str()),
            content: Text(title),
            actions: <Widget>[
              TextButton(child: Text(Ids.cancel.str(),style: const TextStyle(color: Colours.c_E9465D),),onPressed: (){
                Navigator.pop(context,false);
              },),
              TextButton(child: Text(Ids.confirm.str()),onPressed: (){
                Navigator.pop(context,true);
              },),
            ],
          );
        });
  }

}