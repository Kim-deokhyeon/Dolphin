import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/calendar/Calendar_repository.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarPage extends GetView<CalendarController> {
  final name = '학사일정';

  Future<Null> init() async {
    Get.put(CalendarController());
    await CalendarReposiory().getCalendar();
    //await CalendarReposiory().getHoliday();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CalendarController>(
          init: CalendarController(),
          builder: (_) {
            init();
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Positioned(
                    top: 0,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.sizeByHeight(20),
                        vertical: SizeConfig.sizeByHeight(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          oneLine.MainTitle(
                            title: name,
                            fontsize: SizeConfig.sizeByHeight(26),
                            fontweight: FontWeight.w700,
                            isGradient: false,
                          ),
                          CalendarIcon(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.sizeByHeight(68),
                      ),
                      child: CarouselSlider(
                          options: CarouselOptions(
                            height: SizeConfig.sizeByHeight(600),
                            autoPlay: false,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: false,
                            initialPage: 5,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {},
                          ),
                          items: _.monthArray
                              .map((e) => Calendar(
                                    calendarData: _.calendarData,
                                    //holidayData: _.holidayData,
                                    kFirstDay: e,
                                  ))
                              .toList())),
                  Positioned(
                      bottom: SizeConfig.sizeByHeight(35),
                      right: SizeConfig.sizeByWidth(29),
                      child: ElevatedButton(
                          onPressed: () {
                            _launchURL();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding:
                                EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBox('전체일정 보기', 12, FontWeight.w500,
                                  Color(0xFF353B45)),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: SizeConfig.sizeByHeight(12),
                                color: Color(0xFF353B45),
                              )
                            ],
                          ))),
                ],
              ),
            );
          }),
    );
  }
}

_launchURL() async {
  const url =
      'https://www.kmou.ac.kr/onestop/cm/cntnts/cntntsView.do?mi=74&cntntsId=1755';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
