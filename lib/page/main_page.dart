import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_password/base/base_view.dart';
import 'package:remember_password/page/item/password_item.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/page/setting_page.dart';
import 'package:remember_password/utils/getx_utils.dart';
import 'package:remember_password/widget/tap_widget.dart';
import '../base/common_state_widget_x.dart';
import '../color/colors.dart';
import '../language/strings.dart';
import '../widget/werewolf_scaffold.dart';
import 'create_psw_page.dart';
import 'controller/main_controller.dart';

class MainPage extends BaseGetBuilder<MainController> {

  static const String routeName= '/MainPage';

  getController() => MainController();

  @override
  Widget controllerBuilder(BuildContext context, MainController controller) {
    return MyScaffold(
     showLeading: false,
     title: Ids.appName.str(),
      actions: [
        TapWidget(onTap: () {
            GetxUtils.pushNamed(SettingPage.routeName);
        },
        child: Icon(Icons.settings,color: Colours.white,size: 50.w,)),
        10.sizedBoxW,
      ],
      body: CommonStateWidgetX(controller: controller, widgetBuilder: (BuildContext context) {
        return ListView.builder(itemBuilder: (context , index){
          return PasswordItem(model: controller.list[index]);
        },itemCount: controller.list.length,);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          GetxUtils.pushNamed(CreatePswPage.routeName);
        },
        tooltip: 'create new password',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
