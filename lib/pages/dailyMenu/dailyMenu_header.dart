import 'dart:ui';
import 'package:oceanview/common/text/textBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  Widget build(BuildContext context) {
    return OnelineTitle(name: '식단', description: '', stat: '', fontsize1: 20);
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment:
          AlignmentTween(begin: Alignment.center, end: Alignment.bottomLeft)
              .evaluate(animation),
      child: Container(
          margin: EdgeInsets.only(
            bottom: Tween<double>(
                    begin: SizeConfig.sizeByHeight(14),
                    end: SizeConfig.sizeByHeight(28))
                .evaluate(animation),
            left: SizeConfig.sizeByWidth(14),
          ),
          child: TextBox(
              '식단 ',
              Tween<double>(
                      begin: SizeConfig.sizeByHeight(15),
                      end: SizeConfig.sizeByHeight(18))
                  .evaluate(animation),
              FontWeight.w800,
              Color(0xFF353B45))),
    );
  }
}
