// ignore_for_file: constant_identifier_names

import 'package:remember_password/language/string_cn.dart';
import 'package:remember_password/language/string_en.dart';

///获取资源
///IntlUtil.getString(context, Ids.appName)
class Ids {
  static const String appName = 'app_name';
  static const String confirm = 'confirm';
  static const String cancel = 'cancel';
  static const String languageSelect = 'language_select';
  static const String languageZH = 'language_zh';
  static const String languageSimpleZH = 'languageSimpleZH';
  static const String languageEN = 'language_en';
  static const String language = 'language';
  static const String themeColor = 'themeColor';
  static const String setting = 'setting';
  static const String no_data = 'no_data';
  static const String create_psw = 'create_psw';
  static const String psw_lable = 'psw_lable';
  static const String account = 'account';
  static const String password = 'password';
  static const String input_psw_lable = 'input_psw_lable';
  static const String input_account = 'input_account';
  static const String input_password = 'input_password';
  static const String set_gesture_password_hint = 'set_gesture_password_hint';
  static const String set_gesture_password = 'set_gesture_password';
  static const String confim_gesture_password = 'confim_gesture_password';
  static const String check_gesture_password = 'check_gesture_password';
  static const String reset_gesture_password = 'reset_gesture_password';
  static const String set_fingerprint_password = 'set_fingerprint_password';
  static const String close_fingerprint_password = 'close_fingerprint_password';
  static const String check_fingerprint = 'check_fingerprint';
  static const String reset_fingerprint = 'reset_fingerprint';
  static const String check_fingerprint_error = 'check_fingerprint_error';
  static const String enter_home = 'enter_home';
  static const String delete_password = 'delete_password';
  static const String copy_success = 'copy_success';
  static const String change_theme_color = 'change_theme_color';
  static const String select_unlock_method = 'select_unlock_method';
  static const String unlock_method = 'unlock_method';
  static const String fingerprint_unlock = 'fingerprint_unlock';
  static const String gesture_unlock = 'gesture_unlock';
  static const String retry = 'retry';
  static const String tips = 'tips';
  static const String password_error = 'password_error';




}

///不需要翻译的文案
const Map<String, String> noTranslate = {
  Ids.languageZH: '简体中文',
  Ids.languageEN: 'English',
  Ids.languageSimpleZH: '中文',
};

const Map<String, Map<String, String>> localizedSimpleValues = {
  //简体中文
  'zh_CN': languageChinese,
  //英文
  'en_US': languageEnglish,
};
