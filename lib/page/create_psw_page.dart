import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_password/core.dart';
import '../base/base_view.dart';
import '../color/colors.dart';
import '../language/strings.dart';
import '../widget/werewolf_scaffold.dart';
import 'controller/create_psw_controller.dart';

class CreatePswPage extends BaseGetBuilder<CreatePswController> {

  static const String routeName='/CreatePswPage';

  getController() => CreatePswController();

  @override
  Widget controllerBuilder(BuildContext context, CreatePswController controller) {
    return MyScaffold(
      title: Ids.create_psw.str(),
        actions: [
          IconButton(
            icon:  Icon(controller.model == null ?FontAwesomeIcons.plus: FontAwesomeIcons.penToSquare,size: 40.sp,),
            tooltip:'创建你的密码',
            iconSize: 30,
            onPressed: () {
              controller.createPsw();
            },
          )
    ],
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              cursorColor: Colours.primaryColor(context),
              decoration:  InputDecoration(
                labelText: Ids.psw_lable.str(),
                icon: const Icon(Icons.label),
                hintText: Ids.input_psw_lable.str(),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colours.primaryColor(context)
                    )),
              ),
              controller: controller.titleController,
            ),
            Container(height: 10.w,),
            TextField(
              decoration: InputDecoration(
                  labelText: Ids.account.str(),
                  icon: const Icon(Icons.title),
                  hintText: Ids.input_account.str(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colours.primaryColor(context)
                  )),
              ),
              controller: controller.accountController,
            ),
            Container(height: 10.w,),
            TextField(
              decoration: InputDecoration(
                  labelText: Ids.password.str(),
                  icon: const Icon(FontAwesomeIcons.lock),
                  hintText: Ids.input_password.str(),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colours.primaryColor(context)
                    )),
              ),
              controller: controller.pswController,
            ),
          ],
        ),
      ),
    );
  }
}
