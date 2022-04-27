
import 'package:get/get.dart';
import 'package:remember_password/base/base_getx.dart';

import '../../database/db_manager.dart';
import '../../model/password_model.dart';

class MainBindings extends BaseBindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}


class MainController extends BaseXController  {

  List<PasswordModel> list = [];

  @override
  void onReady() async {
    super.onReady();
    getPswList();
  }

  getPswList() async {
    list = await DbManager.instance().getPasswords();
    if(list.isNotEmpty){
      setIdleState();
    }else{
      setEmptyState();
    }
  }

  deletePsw(PasswordModel model){
    list.remove(model);
    if(list.isNotEmpty){
      setIdleState();
    }else{
      setEmptyState();
    }
    DbManager.instance().deletePassword(model);
  }

}