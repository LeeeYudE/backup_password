import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:remember_password/base/constant.dart';
import 'package:remember_password/language/language_model.dart';
import 'package:remember_password/page/main_page.dart';
import 'package:remember_password/utils/getx_utils.dart';
import 'package:remember_password/utils/language_util_v2.dart';
import '../../base/base_getx.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

import '../../language/strings.dart';
import '../dialog/comfin_dialog.dart';
import 'package:remember_password/core.dart';

class SplashController extends BaseXController  {

  static const FINGERPRINT_STATUS_INIT = 0;
  static const FINGERPRINT_STATUS_CHECK = 1;///正在指纹识别
  static const FINGERPRINT_STATUS_ERROR = 2;///指纹识别失败

  bool initApp = false;
  String? gesturePassword;
  int fingerprintStatus = 0;///1正在检查 2检查失败
  bool? hasFingerprint;
  bool get hasGesturePassword => !TextUtil.isEmpty(gesturePassword);

  @override
  void onReady() {
    super.onReady();
    init();
  }

  init() async {
    initApp = SpUtil.containsKey(Constant.SP_GESTURE_PASSWORD)??false;

    if(initApp){
      gesturePassword = SpUtil.getString(Constant.SP_GESTURE_PASSWORD,defValue: null);
      bool canCheckBiometrics = await LocalAuthentication.canCheckBiometrics;
      if(canCheckBiometrics){
        hasFingerprint = SpUtil.getBool(Constant.SP_FINGERPRINT_PASSWORD, defValue: false);
      }
    }

    setState(ViewState.Idle);
  }

  switchFingerprintStatus(bool status) async {
    bool didAuthenticate = await LocalAuthentication.authenticate(localizedReason: Ids.check_fingerprint.str(),  useErrorDialogs: true,);
    if(didAuthenticate){
      hasFingerprint = status;
      update();
      SpUtil.putBool(Constant.SP_FINGERPRINT_PASSWORD, status);
    }else{
      Ids.check_fingerprint_error.str();
    }
  }

  authenticate() async {
    _updateFingerprintStatus(FINGERPRINT_STATUS_CHECK);
    bool didAuthenticate = await LocalAuthentication.authenticate(localizedReason: Ids.check_fingerprint.str(),  useErrorDialogs: true,);
    if(didAuthenticate){
      GetxUtils.pushNamed(MainPage.routeName);
    }else{
      _updateFingerprintStatus(FINGERPRINT_STATUS_ERROR);
    }
  }

  _updateFingerprintStatus(int status){
    fingerprintStatus = status;
    setState(ViewState.Idle);
  }

  setLocalAuth(BuildContext context) async {
    bool canCheckBiometrics = await LocalAuthentication.canCheckBiometrics;
    if(canCheckBiometrics){
      setFingerprint(context);
    }else{
      GetxUtils.pushNamed(MainPage.routeName);
    }
  }

  setFingerprint(BuildContext context) async {
    bool canCheckBiometrics = await LocalAuthentication.canCheckBiometrics;
    print('availableBiometrics ${canCheckBiometrics.toString()}');
    if (canCheckBiometrics) {// 指纹.
      var result = await GetxUtils.showConfimDialog(context,Ids.set_gesture_password_hint.str());
      if(result??false){
        _updateFingerprintStatus(FINGERPRINT_STATUS_CHECK);
        bool didAuthenticate = await LocalAuthentication.authenticate(localizedReason: Ids.set_gesture_password.str(),);
        if(didAuthenticate){
          SpUtil.putBool(Constant.SP_FINGERPRINT_PASSWORD, true);
          GetxUtils.offNamed(MainPage.routeName);
        }else{
          _updateFingerprintStatus(FINGERPRINT_STATUS_ERROR);
        }
      }
    }
  }

  void selectLanguage(LanguageModel e) {
    LanguageUtilV2.setLocalModel(e);
    initApp = true;
    update();
  }

}