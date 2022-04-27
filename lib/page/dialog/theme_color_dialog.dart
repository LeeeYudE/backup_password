import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remember_password/core.dart';
import 'package:remember_password/widget/tap_widget.dart';
import '../../color/colors.dart';
import '../../language/strings.dart';
import '../../utils/getx_utils.dart';

class ThemeColorDialog extends StatefulWidget {

   ThemeColorDialog({Key? key}) : super(key: key);

  @override
  State<ThemeColorDialog> createState() => _ThemeColorDialogState();
}

class _ThemeColorDialogState extends State<ThemeColorDialog> {
  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: () {
        GetxUtils.pop();
      },
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 600.w,
                height: 700.w,
                decoration: BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 20.w),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Ids.change_theme_color.str(), style: TextStyle(color: Colours.c_212129,fontSize: 32.sp)),
                    20.sizedBoxH,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: Colours.themeList.map<Widget>((e) => TapWidget(
                        onTap: () {
                            Colours.changeThemeColor(Colours.themeList.indexWhere((element) => element == e));
                            setState(() {});
                        },
                        child: Container(
                          height: 100.w,
                          padding: EdgeInsets.all(10.w),
                          decoration: e == Colours.currentColor() ? e.borderDecoration(borderRadius: 10.w):null,
                          child: Container(
                            color: e,
                          ),
                        ),
                      )).toList(),
                    )
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
