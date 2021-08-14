import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';
import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';
import 'package:oceanview/services/urlUtils.dart';

class ShuttleBus extends GetView<ShuttleBusController> {
  findShuttleBusSubTitle(item) {
    return item == '하리상가' ? 'beta' : '';
  }

  @override
  Widget build(BuildContext context) {
    ShuttleBusRepository().getNextShuttle();
    return GetBuilder<ShuttleBusController>(
        init: ShuttleBusController(),
        builder: (_) {
          var remainTime = [];
          var arriveTime = [];
          var hariRemainTime = [];

          for (var i = 0; i < _.nextShuttle.length; i++) {
            var differenceMinute =
                _.nextShuttle[i].difference(DateTime.now()).inMinutes;
            hariRemainTime.add((differenceMinute + 6).toString());
            remainTime.add(DateFormat('m분 s초').format(differenceMinute));
            arriveTime.add(DateFormat('HH:mm').format(_.nextShuttle[i]));
          }

          return GlassMorphism(
            width: SizeConfig.sizeByWidth(300),
            height: SizeConfig.sizeByHeight(478),
            widget: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.sizeByWidth(8),
                    horizontal: SizeConfig.sizeByHeight(16)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '정류장 선택',
                            style: TextStyle(
                              color: Color(0xff005A9E),
                              fontSize: SizeConfig.sizeByHeight(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(55),
                        ),
                        Column(children: [
                          _.selectedStation == '학교종점 (아치나루터)'
                              ? TextBox('이전차는 약 3분전에 지나갔어요', 12,
                                  FontWeight.w400, Color(0xFF353B45))
                              : hariRemainTime.length > 0 &&
                                      int.parse(hariRemainTime[0]) <= 6
                                  ? TextBox('이전차는 약 3분전에 지나갔어요', 12,
                                      FontWeight.w400, Color(0xFF353B45))
                                  : SizedBox(
                                      height: SizeConfig.sizeByHeight(14),
                                    ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(18),
                          ),
                          Container(
                            height: SizeConfig.sizeByHeight(280),
                            child: Stack(
                              children: [
                                Container(
                                  width: 1,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.sizeByWidth(40)),
                                  height: SizeConfig.sizeByHeight(290),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF4BA6FF).withOpacity(0),
                                          Color(0xFF3299F3),
                                          Color(0xFF4BA6FF).withOpacity(0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 0.5, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: _.isLoading
                                      ? [Container()]
                                      : _.selectedStation == '학교종점 (아치나루터)'
                                          ? [
                                              FirstArrive(
                                                  _.nextShuttle.length > 0
                                                      ? remainTime[0]
                                                      : '없음',
                                                  _.nextShuttle.length > 0
                                                      ? arriveTime[0]
                                                      : ' '),
                                              SecondArrive(
                                                  _.nextShuttle.length > 1
                                                      ? remainTime[1]
                                                      : '없음',
                                                  _.nextShuttle.length > 1
                                                      ? arriveTime[1]
                                                      : ' '),
                                              ThirdArrive(
                                                  _.nextShuttle.length > 2
                                                      ? remainTime[2]
                                                      : '없음',
                                                  _.nextShuttle.length > 2
                                                      ? arriveTime[2]
                                                      : ' ')
                                            ]
                                          : [
                                              FirstArrive(
                                                  _.nextShuttle.length > 0
                                                      ? '${hariRemainTime[0]}분 후'
                                                      : '없음',
                                                  ' '),
                                              SecondArrive(
                                                  _.nextShuttle.length > 1
                                                      ? '${hariRemainTime[1]}분 후'
                                                      : '없음',
                                                  ' '),
                                              ThirdArrive(
                                                  _.nextShuttle.length > 2
                                                      ? '${hariRemainTime[2]}분 후'
                                                      : '없음',
                                                  ' ')
                                            ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () => UrlUtils.launchURL(
                                    'https://www.kmou.ac.kr/kmou/cm/cntnts/cntntsView.do?mi=1418&cntntsId=328'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.all(
                                      SizeConfig.sizeByHeight(8.5)),
                                ),
                                child: Row(
                                  children: [
                                    TextBox('전체시간보기', 12, FontWeight.w500,
                                        Color(0xFF353B45)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: SizeConfig.sizeByHeight(12),
                                      color: Color(0xFF353B45),
                                    )
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: SizeConfig.sizeByHeight(24),
                      child: Container(
                        width: SizeConfig.sizeByWidth(268),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Dropdown(
                              _.stationList,
                              _.selectedStation,
                              (value) {
                                value == '학교종점 (아치나루터)'
                                    ? ShuttleBusRepository().getNextShuttle()
                                    : () {};
                                _.setSelectedStation(value);
                              },
                              findSubTitle: findShuttleBusSubTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}

// class BeforeArrive extends StatelessWidget {
//   const BeforeArrive({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//             margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(5)),
//             width: SizeConfig.sizeByWidth(80),
//             child: TextBox('학교에서', 14, FontWeight.w500, Color(0xFF717171))),
//         SizedBox(
//           width: SizeConfig.sizeByWidth(15),
//         ),
//         TextBox('약 3분전 출발', 12, FontWeight.w500, Color(0xFF353B45))
//       ],
//     );
//   }
// }

class FirstArrive extends StatelessWidget {
  const FirstArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_shuttle.png',
              width: SizeConfig.sizeByHeight(80),
              height: SizeConfig.sizeByHeight(80),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w700, Color(0xFF353B45))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 30,
                    FontWeight.w700, Color(0xFF353B45)),
            arriveTime != ' '
                ? Column(
                    children: [
                      TextBox(
                        '$arriveTime',
                        14,
                        FontWeight.w400,
                        Color(0xFF717171),
                      ),
                    ],
                  )
                : SizedBox(
                    height: SizeConfig.sizeByHeight(4),
                  ),
          ],
        ),
      ],
    );
  }
}

class SecondArrive extends StatelessWidget {
  const SecondArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/notiIcon_next.png',
              width: SizeConfig.sizeByHeight(60),
              height: SizeConfig.sizeByHeight(60),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w700, Color(0xFF353B45))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 24,
                    FontWeight.w700, Color(0xFF353B45)),
            arriveTime != ' '
                ? TextBox(
                    '$arriveTime',
                    14,
                    FontWeight.w400,
                    Color(0xFF717171),
                  )
                : SizedBox(
                    height: SizeConfig.sizeByHeight(5),
                  ),
          ],
        ),
      ],
    );
  }
}

class ThirdArrive extends StatelessWidget {
  const ThirdArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/notiIcon_later.png',
              width: SizeConfig.sizeByHeight(30),
              height: SizeConfig.sizeByHeight(30),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w700, Color(0xFF353B45))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 18,
                    FontWeight.w500, Color(0xFF353B45)),
            arriveTime != ' '
                ? Column(
                    children: [
                      TextBox(
                        '$arriveTime',
                        14,
                        FontWeight.w400,
                        Color(0xFF717171),
                      ),
                      SizedBox(
                        height: SizeConfig.sizeByHeight(2),
                      ),
                    ],
                  )
                : SizedBox(
                    height: SizeConfig.sizeByHeight(5),
                  ),
          ],
        ),
      ],
    );
  }
}

class HomeDeparted extends StatelessWidget {
  const HomeDeparted(this.remainTime, {Key? key}) : super(key: key);

  final String? remainTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_home.png',
              width: SizeConfig.sizeByHeight(50),
              height: SizeConfig.sizeByHeight(50),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextBox(
                    int.parse(remainTime!) < 0
                        ? '학교에서 ${-1 * int.parse(remainTime!)}분 전 출발'
                        : '학교에서 $remainTime분 후 출발',
                    14,
                    FontWeight.w500,
                    Color(0xFF353B45)),
                SizedBox(
                  width: SizeConfig.sizeByWidth(10),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.sizeByHeight(5),
            )
          ],
        )
      ],
    );
  }
}
