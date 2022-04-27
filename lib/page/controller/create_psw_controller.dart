
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remember_password/base/base_getx.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/database/db_manager.dart';
import 'package:remember_password/model/password_model.dart';

import '../../language/strings.dart';
import '../../utils/datetime_util.dart';
import 'main_controller.dart';

class CreatePswController extends BaseXController  {


  TextEditingController titleController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController pswController = TextEditingController();
  final MainController _mainController = Get.find();
  PasswordModel? model;

  @override
  void onReady() {
    super.onReady();
    model = Get.arguments;
    if(model != null){
      titleController.text = model!.lable!;
      accountController.text = model!.account??'';
      pswController.text = model!.password!;
    }
    update();
  }

  void createPsw() async {
    String lable = titleController.text.toString().trim();
    if(lable.isEmpty){
      Ids.input_psw_lable.str().toast();
      return;
    }

    String account = accountController.text.toString().trim();
    // if(account.isEmpty){
    //   '请输入账号'.toast();
    //   return;
    // }
    String password = pswController.text.toString().trim();
    if(password.isEmpty){
      Ids.input_password.str().toast();
      return;
    }
    if(model != null){
      model!.lable = lable;
      model!.account = account;
      model!.password = password;
      model!.createTime = DateTimeUtil.dateTimeNowMilli();
    }else{
      model = PasswordModel(
        lable:lable,
        account:account,
        password:password,
        createTime:DateTimeUtil.dateTimeNowMilli(),
      );
    }
    await DbManager.instance().savePassword(model!);
    _mainController.getPswList();
    Get.back();

  }



}