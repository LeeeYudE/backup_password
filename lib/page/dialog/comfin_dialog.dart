import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/widget/tap_widget.dart';
import '../../color/colors.dart';
import '../../language/strings.dart';
import '../../utils/getx_utils.dart';

class ConfimDialog extends StatelessWidget {

  String title;

   ConfimDialog({required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 290.w,
              width: 600.w,
              decoration: BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.circular(12.w),
              ),
              padding: EdgeInsets.symmetric(vertical: 40.w,horizontal: 40.w),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Spacer(),
                  Text(title, style: TextStyle(color: Colours.c_212129,fontSize: 32.sp)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TapWidget(
                        onTap: () {
                          GetxUtils.pop(false);
                        },
                        child: Text(Ids.cancel.str(),style: TextStyle(color: Colours.c_FF4E32,fontSize: 28.sp),),
                      ),
                      40.sizedBoxW,
                      TapWidget(
                        onTap: () {
                          GetxUtils.pop(true);
                        },
                        child: Text(Ids.confirm.str(),style: TextStyle(color: Colours.c_4E8DF4,fontSize: 28.sp),)),
                    ],
                  ),
                  20.sizedBoxH
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}
