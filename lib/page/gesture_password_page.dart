import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesture_password_widget/widget/gesture_password_widget.dart';
import 'package:get/get.dart';
import 'package:remember_password/base/constant.dart';
import 'package:remember_password/page/main_page.dart';
import 'package:remember_password/utils/getx_utils.dart';
import 'package:remember_password/widget/werewolf_scaffold.dart';
import 'package:remember_password/core.dart';

import '../color/colors.dart';
import '../language/strings.dart';

class GesturePasswordPage extends StatefulWidget {

  static const TYPE_SET_GESTURE = 0;
  static const TYPE_CHECK_GESTURE = 1;
  static const TYPE_RESET_GESTURE = 2;

  static const String routeName= '/SetGesturePasswordPage';

  const GesturePasswordPage({Key? key}) : super(key: key);

  @override
  State<GesturePasswordPage> createState() => _GesturePasswordPageState();
}

class _GesturePasswordPageState extends State<GesturePasswordPage> {

  String? _password;
  String? _resetPassword;
  bool _reset = false;
  int _type = GesturePasswordPage.TYPE_SET_GESTURE;
  List<int>? answer;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _type = Get.arguments??GesturePasswordPage.TYPE_SET_GESTURE;
    if(_type != GesturePasswordPage.TYPE_SET_GESTURE){
      _password = SpUtil.getString(Constant.SP_GESTURE_PASSWORD,defValue: null);
      answer = _password?.split(',').map((e) => int.parse(e)).toList();
    }
  }

  bool isType(int type) => _type == type;

  get _title => isType(GesturePasswordPage.TYPE_SET_GESTURE)?Ids.set_gesture_password.str():isType(GesturePasswordPage.TYPE_CHECK_GESTURE)?Ids.check_gesture_password.str():Ids.reset_gesture_password.str();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: _title,
      body: _buildBody(),
    );
  }

  _buildBody(){
    String hint = '' ;
    switch(_type){
      case GesturePasswordPage.TYPE_SET_GESTURE:
        hint = _password == null ? Ids.set_gesture_password.str():Ids.confim_gesture_password.str();
        break;
      case GesturePasswordPage.TYPE_CHECK_GESTURE:
        hint = Ids.check_gesture_password.str();
        break;
      case GesturePasswordPage.TYPE_RESET_GESTURE:

        hint = !_reset ? Ids.check_gesture_password.str(): _resetPassword == null ? Ids.set_gesture_password.str():Ids.confim_gesture_password.str();
        break;
    }
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          100.sizedBoxH,
          Text(hint,style: TextStyle(color: Colours.theme_color_1,fontSize: 32.sp),),
          100.sizedBoxH,
          GesturePasswordWidget(
            lineColor: Colours.theme_color_1,
            errorLineColor: Colors.redAccent,
            singleLineCount: 4,
            identifySize: 80.w,
            minLength: 4,
            hitShowMilliseconds: 40,
            errorItem: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            normalItem: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Colours.theme_color_1,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            selectedItem: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: Colours.theme_color_1,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            hitItem: Container(
              width: 15.0,
              height: 15.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            answer: answer,
            color: Colours.white,
            onComplete: (data) async {
              if(isType(GesturePasswordPage.TYPE_SET_GESTURE)){
                if(_password == null){
                  _password = data.join(',');
                  setState(() {});
                }else{
                  if(_password == data.join(',')){
                    await SpUtil.putString(Constant.SP_GESTURE_PASSWORD, _password!);
                    GetxUtils.pop(_password);
                  }else{
                    Ids.password_error.str().toast();
                  }
                }
              }else if(isType(GesturePasswordPage.TYPE_CHECK_GESTURE)) {
                if(_password == data.join(',')){
                  GetxUtils.offAllNamed(MainPage.routeName);
                }else{
                  Ids.password_error.str().toast();
                }
              }else {
                if(!_reset){
                  if(_password == data.join(',')){
                    _reset = true;
                    setState(() {});
                  }else{
                    Ids.password_error.str().toast();
                  }
                }else{
                  if(_resetPassword == null){
                    _resetPassword = data.join(',');
                    answer = data.cast<int>();
                    setState(() {});
                  }else{
                    if(_resetPassword == data.join(',')){
                      await SpUtil.putString(Constant.SP_GESTURE_PASSWORD, _resetPassword!);
                      GetxUtils.pop(true);
                    }else{
                      Ids.password_error.str().toast();
                    }
                  }
                }
              }
            },
          )
        ],
      ),
    );
  }

}
