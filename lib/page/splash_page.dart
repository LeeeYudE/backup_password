import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:remember_password/base/base_view.dart';
import 'package:remember_password/base/common_state_widget_x.dart';
import 'package:remember_password/color/colors.dart';
import 'package:remember_password/page/gesture_password_page.dart';
import 'package:remember_password/page/main_page.dart';
import 'package:remember_password/utils/language_util_v2.dart';
import 'package:remember_password/utils/utils.dart';
import 'package:remember_password/widget/tap_widget.dart';
import 'package:remember_password/widget/werewolf_scaffold.dart';
import 'package:remember_password/core.dart';

import '../language/strings.dart';
import '../utils/getx_utils.dart';
import 'controller/splash_controller.dart';

class SplashPage extends BaseGetBuilder<SplashController> {

  @override
  SplashController? getController() => SplashController();

  @override
  Widget controllerBuilder(BuildContext context, SplashController controller) {
    return MyScaffold(
      showLeading: false,
      body: _buildBody(controller),
    );
  }

  _buildBody(SplashController controller){
    return CommonStateWidgetX(
      controller: controller,
      widgetBuilder: (BuildContext context) {
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              200.sizedBoxH,
              Container(width: 200.w,height: 200.w,decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 15.w),
                child: Center(child: Text('Hi',style: TextStyle(color: Colours.primaryColor(context),fontSize: 50.sp),),),),
              100.sizedBoxH,
              if(!controller.initApp)
                _buildLanguage(context,controller),
              if(controller.initApp && controller.gesturePassword != null &&  controller.fingerprintStatus == SplashController.FINGERPRINT_STATUS_INIT)
              _buildCheckItem(context,controller),
              if(controller.initApp && controller.gesturePassword == null)
                _buildSetFingerprint(context,controller),
              if(controller.fingerprintStatus == SplashController.FINGERPRINT_STATUS_CHECK)
                _buildFingerprint(context,controller),
              if(controller.fingerprintStatus == SplashController.FINGERPRINT_STATUS_ERROR)
                _buildFingerprintError(context,controller)
            ],
          ),
        );
      },
    );
  }

  _buildCheckItem(BuildContext context,SplashController controller){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(Ids.select_unlock_method.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),
        if(controller.hasFingerprint??false)
        TapWidget(
          onTap: () {
            controller.authenticate();
          },
          child: Container(
            width: 300.w,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
            decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 5.w),
            child: Center(child: Text(Ids.fingerprint_unlock.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),),),
        ),
        if(controller.hasGesturePassword)
        TapWidget(
          onTap: () {
            GetxUtils.pushNamed(GesturePasswordPage.routeName,arguments: GesturePasswordPage.TYPE_CHECK_GESTURE);
          },
          child: Container(
            width: 300.w,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
            decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 5.w),
            child: Center(child: Text(Ids.gesture_unlock.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),),),
        )
      ],
    );
  }

  _buildSetFingerprint(BuildContext context,SplashController controller){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[ TapWidget(
        onTap: () async {
          var result =  await GetxUtils.pushNamed(GesturePasswordPage.routeName);
          if(!TextUtil.isEmpty(result)){
            controller.gesturePassword = result;
            controller.setLocalAuth(context);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
          decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 5.w),
          child: Center(child: Text(Ids.set_gesture_password.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),),),
      )],
    );
  }

  _buildFingerprint(BuildContext context,SplashController controller){
    return Container(
      margin: EdgeInsets.only(top: 50.w),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Ids.check_fingerprint.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),
          40.sizedBoxH,
          Icon(FontAwesomeIcons.fingerprint,size: 100.w,color: Colours.primaryColor(context),),
          40.sizedBoxH,
        ],
      ),
    );
  }

  _buildFingerprintError(BuildContext context,SplashController controller){
    return Container(
      margin: EdgeInsets.only(top: 50.w),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Ids.check_fingerprint_error.str(),style: TextStyle(color: Colours.c_E73E24,fontSize: 32.sp),),
          40.sizedBoxH,
          Icon(FontAwesomeIcons.fingerprint,size: 100.w,color: Colours.c_E73E24,),
          40.sizedBoxH,
          if(controller.hasFingerprint == null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TapWidget(
                onTap: () {
                  GetxUtils.pushNamed(MainPage.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
                  decoration: Colours.c_E73E24.borderDecoration(borderRadius: 24.w,width: 5.w),
                  child: Center(child: Text(Ids.enter_home.str(),style: TextStyle(color: Colours.c_E73E24,fontSize: 32.sp),),),),
              ),
              40.sizedBoxW,
              TapWidget(
                onTap: () {
                  controller.setFingerprint(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
                  decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 5.w),
                  child: Center(child: Text(Ids.reset_fingerprint.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),),),
              )
            ],
          )else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TapWidget(
                onTap: () {
                  controller.authenticate();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
                  decoration: Colours.c_E73E24.borderDecoration(borderRadius: 24.w,width: 5.w),
                  child: Center(child: Text(Ids.retry.str(),style: TextStyle(color: Colours.c_E73E24,fontSize: 32.sp),),),),
              )],
            )
        ],
      ),
    );
  }

  _buildLanguage(BuildContext context,SplashController controller){
    return Column(
      children: [
        Text(Ids.languageSelect.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),), ...LanguageUtilV2.getLanguages().map<Widget>((e) => TapWidget(
        onTap: () {
          controller.selectLanguage(e);
        },
        child: Container(
            width: 300.w,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
            decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 24.w,width: 5.w),
            child: Center(child: Text(e.titleId!.str(),style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.sp),),)),
      )).toList()
      ],
    );
  }

}
