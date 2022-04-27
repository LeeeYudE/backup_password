import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_password/base/common_state_widget_x.dart';
import 'package:remember_password/color/colors.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/language/strings.dart';
import 'package:remember_password/utils/getx_utils.dart';
import 'package:remember_password/utils/language_util_v2.dart';
import 'package:remember_password/widget/tap_widget.dart';
import '../base/base_view.dart';
import '../language/language_model.dart';
import '../widget/werewolf_scaffold.dart';
import 'controller/splash_controller.dart';
import 'dialog/theme_color_dialog.dart';
import 'gesture_password_page.dart';

class SettingPage extends BaseGetBuilder<SplashController> {

  @override
  SplashController? getController() => SplashController();


  static const String routeName= '/SettingPage';


  @override
  Widget controllerBuilder(BuildContext context, SplashController controller) {
    return MyScaffold(
      title: Ids.setting.str(),
      body: _buildBody(context,controller),
    );
  }


  Widget _buildBody(BuildContext context, SplashController controller) {
    return CommonStateWidgetX(
      controller: controller,
      widgetBuilder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          width: double.infinity,
          child: Column(
            children: [
              TapWidget(
                onTap: () {
                  GetxUtils.showCommonDialog(ThemeColorDialog());
                },
                child: Row(
                  children: [
                    Text(Ids.themeColor.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),
                    20.sizedBoxW,
                    Container(width: 32.w,height: 32.w,decoration: Colours.primaryColor(context).boxDecoration(borderRadius: 6.w),)
                  ],
                ),
              ),
              20.sizedBoxH,
              Colours.line_color.toLine(1.w),
              20.sizedBoxH,
              Row(
                children: [
                  Text(Ids.language.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),
                  ...LanguageUtilV2.getLanguages().map<Widget>((e) => _buildLanguageItem(context,e)).toList(),
                ],
              ),
              20.sizedBoxH,
              Colours.line_color.toLine(1.w),
              20.sizedBoxH,
              _buildUnlockMother(context,controller),
            ],
          ),
        );
      },
    );
  }

  _buildUnlockMother(BuildContext context, SplashController controller){
    return Row(
      children: [
        Text(Ids.unlock_method.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),
        if(controller.hasFingerprint != null)
        TapWidget(
          onTap: () async {
            var showConfinDialog = await GetxUtils.showConfimDialog(context, controller.hasFingerprint!?Ids.close_fingerprint_password.str():Ids.set_fingerprint_password.str());
            if(showConfinDialog??false){
              controller.switchFingerprintStatus(!controller.hasFingerprint!);
            }
          },
          child: Container(decoration: (Colours.primaryColor(context).borderDecoration(borderRadius: 4.w,width: 4.w)),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
            margin: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                Text(Ids.fingerprint_unlock.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 24.sp),),
                  Icon(controller.hasFingerprint!?Icons.done:Icons.close,color: Colours.primaryColor(context),size: 24.sp,)
              ],
            ),),
        ),
        TapWidget(
          onTap: () {
            GetxUtils.pushNamed(GesturePasswordPage.routeName,arguments: GesturePasswordPage.TYPE_RESET_GESTURE);
          },
          child: Container(decoration: (Colours.primaryColor(context).borderDecoration(borderRadius: 4.w,width: 4.w)),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
            margin: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                Text(Ids.gesture_unlock.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 24.sp),),
                  Icon(Icons.done,color: Colours.primaryColor(context),size: 24.sp,)
              ],
            ),),
        )
      ],
    );
  }

  _buildLanguageItem(BuildContext context ,LanguageModel model){
    var currentLanguage = LanguageUtilV2.getCurrentLanguage();
    Color _color = currentLanguage.languageCode == model.languageCode?Colours.primaryColor(context):Colours.c_999999;
    return TapWidget(
      onTap: () {
        LanguageUtilV2.setLocalModel(model);
      },
      child: Container(decoration: (_color.borderDecoration(borderRadius: 4.w,width: 4.w)),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
        margin: EdgeInsets.only(left: 20.w),
        child: Row(
          children: [
            Text(model.titleId?.str()??'',style: TextStyle(color: _color,fontSize: 24.sp),),
            if(currentLanguage.languageCode == model.languageCode)
              Icon(Icons.done,color: Colours.primaryColor(context),size: 24.sp,)
          ],
        ),),
    );
  }

}
