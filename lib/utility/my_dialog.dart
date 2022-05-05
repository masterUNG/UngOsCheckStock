// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungoschekstork/utility/my_constant.dart';
import 'package:ungoschekstork/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> myShowModalButtonSheet(
      {required String title,
      required String subTitle,
      required Function() pressFunc,
      required String firstButton}) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.qr_code_2,
            size: 120,
          ),
          ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          ShowText(text: subTitle),
          TextButton(onPressed: pressFunc, child: ShowText(text: firstButton, textStyle: MyConstant().h3SActiontyle(),))
        ],
      ),
    );
  }
}
