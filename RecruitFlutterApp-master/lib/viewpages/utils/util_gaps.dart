import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recruit_app/colors_utils.dart';

import 'util_dimen.dart';


/// 间隔
class UtilGaps {
  /// 间隔 线

  static Widget line1 = const Divider(height: UtilDimens.gap_dp1,color: ColorsUtils.black_120000);

  static Widget line4 = Container(height: 6,color: Color(0xfff4f4f4));
  static  Widget g_line_h =  Container(height: UtilDimens.gap_dp1,color: ColorsUtils.black_120000);
  static  Widget g_line_v =  Container(width: UtilDimens.gap_dp1,color: ColorsUtils.black_120000);
  static Widget bline1 = const Divider(height: UtilDimens.gap_dp1,color: Colors.black38);
  
  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: UtilDimens.gap_dp4);
  static const Widget hGap5 = const SizedBox(width: UtilDimens.gap_dp5);
  static const Widget hGap8 = const SizedBox(width: UtilDimens.gap_dp8);
  static const Widget hGap10 = const SizedBox(width: UtilDimens.gap_dp10);
  static const Widget hGap12 = const SizedBox(width: UtilDimens.gap_dp12);
  static const Widget hGap15 = const SizedBox(width: UtilDimens.gap_dp15);
  static const Widget hGap16 = const SizedBox(width: UtilDimens.gap_dp16);
  static const Widget hGap20 = const SizedBox(width: UtilDimens.gap_dp20);
  static const Widget hGap32 = const SizedBox(width: UtilDimens.gap_dp32);
  static const Widget hGap72 = const SizedBox(width: UtilDimens.gap_dp72);

  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: UtilDimens.gap_dp4);
  static const Widget vGap5 = const SizedBox(height: UtilDimens.gap_dp5);
  static const Widget vGap8 = const SizedBox(height: UtilDimens.gap_dp8);
  static const Widget vGap10 = const SizedBox(height: UtilDimens.gap_dp10);
  static const Widget vGap12 = const SizedBox(height: UtilDimens.gap_dp12);
  static const Widget vGap15 = const SizedBox(height: UtilDimens.gap_dp15);
  static const Widget vGap16 = const SizedBox(height: UtilDimens.gap_dp16);
  static const Widget vGap20 = const SizedBox(height: UtilDimens.gap_dp20);
  static const Widget vGap24 = const SizedBox(height: UtilDimens.gap_dp24);
  static const Widget vGap32 = const SizedBox(height: UtilDimens.gap_dp32);
  static const Widget vGap42 = const SizedBox(height: UtilDimens.gap_dp42);
  static const Widget vGap50 = const SizedBox(height: UtilDimens.gap_dp50);
  static const Widget vGap80 = const SizedBox(height: UtilDimens.gap_dp80);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );
  
  static const Widget empty = const SizedBox.shrink();
}
