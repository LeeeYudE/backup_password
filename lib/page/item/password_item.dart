import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:remember_password/color/colors.dart';
import 'package:remember_password/model/password_model.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/utils/getx_utils.dart';

import '../../language/strings.dart';
import '../create_psw_page.dart';
import '../dialog/comfin_dialog.dart';
import '../../widget/tap_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../controller/main_controller.dart';

class PasswordItem extends StatefulWidget {
  
  PasswordModel model;

  PasswordItem({required this.model,Key? key}) : super(key: key);

  @override
  State<PasswordItem> createState() => _PasswordItemState();
}

class _PasswordItemState extends State<PasswordItem> with SingleTickerProviderStateMixin {
  bool showPsw = false;
  late SlidableController _controller;
  final MainController _mainController = Get.find();

  @override
  void initState() {
    _controller  = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: _controller,
      actionExtentRatio: 0.15,
      secondaryActions:[
        Container(
          width: 100.w,
          child: Center(child: TapWidget(onTap: () async {
            _controller.activeState?.close();
            bool? result = await GetxUtils.showConfimDialog(context,Ids.delete_password.str());
            if(result??false){
              _mainController.deletePsw(widget.model);
            }
          }, child: Icon(Icons.delete,size: 50.w,color: Colours.primaryColor(context),)),
          ),
        )
      ],
      actionPane: const SlidableDrawerActionPane(),
      child: SlideAction(
        child: Container(
          decoration: Colours.primaryColor(context).borderDecoration(borderRadius: 12.w),
          margin: EdgeInsets.only(right:20.w,left: 20.w,top: 20.w),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.label,color: Colours.primaryColor(context)),
                  10.sizedBoxW,
                  Expanded(child: Text(widget.model.lable??'',style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.w),)),
                  Text(widget.model.createTime?.commonDateTime()??'',style: TextStyle(color:Colours.primaryColor(context),fontSize: 28.w),),
                  10.sizedBoxW,
                  TapWidget(onTap: () {
                    GetxUtils.pushNamed(CreatePswPage.routeName,arguments: widget.model);
                  },
                  child: Icon(FontAwesomeIcons.penToSquare,color: Colours.primaryColor(context),size: 32.w,))
                ],
              ),
              if(!TextUtil.isEmpty(widget.model.account??''))
              10.sizedBoxH,
              if(!TextUtil.isEmpty(widget.model.account??''))
              Row(
                children: [
                   Icon(Icons.title,color: Colours.primaryColor(context)),
                  10.sizedBoxW,
                  Expanded(child: Text(widget.model.account??'',style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.w),)),
                  20.sizedBoxW,
                  TapWidget(
                    child: Icon(FontAwesomeIcons.copy,color: Colours.primaryColor(context),size: 32.w,),
                    onTap: (){
                      widget.model.password!.copy2Clipboard();
                    },
                  ),
                ],
              ),
              10.sizedBoxH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.lock,size: 32.w,color: Colours.primaryColor(context),),
                  10.sizedBoxW,
                  Expanded(child: Text(showPsw?widget.model.password!:widget.model.password?.toPassword()??'',style: TextStyle(color: Colours.primaryColor(context),fontSize: 32.w,height: 1),)),
                  TapWidget(
                    child: Icon(showPsw?FontAwesomeIcons.eye:FontAwesomeIcons.eyeLowVision,color: Colours.primaryColor(context),size: 32.w,),
                    onTap: (){
                      setState(() {
                        showPsw = !showPsw;
                      });
                    },
                  ),
                  20.sizedBoxW,
                  TapWidget(
                    child: Icon(FontAwesomeIcons.copy,color: Colours.primaryColor(context),size: 32.w,),
                    onTap: (){
                      widget.model.password!.copy2Clipboard();
                    },
                  ),
                ],
              ),
              10.sizedBoxH,
            ],
          ),
        ),
      ),
    );
  }
}
