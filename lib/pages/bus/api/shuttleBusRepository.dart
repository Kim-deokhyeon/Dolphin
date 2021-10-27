import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';

class ShuttleBusRepository {
  List<dynamic> apiToJson(response) {
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNextShuttle = jsonResult['data'];
      final previousShuttle = jsonNextShuttle['previous'] ?? {'type': 'none'};
      final nextShuttle = jsonNextShuttle['next'] ?? [];

      return [previousShuttle, nextShuttle];
    } else {
      print('error ${response.statusCode}');
      return [[], []];
    }
  }

  Future<List<dynamic>> fetchNextShuttle() async {
    return apiToJson(await FetchAPI().fetchNextShuttle());
  }

  Future<List<dynamic>> fetchShuttleList() async {
    return apiToJson(await FetchAPI().fetchShuttleList());
  }

  getNextShuttle() async {
    Get.put(ShuttleBusController());
    Get.find<ShuttleBusController>().setIsLoading(true);
    Get.find<ShuttleBusController>().setNextShuttle(await fetchNextShuttle());
    Get.find<ShuttleBusController>().setShuttleRemainTimes();
    await Future.delayed(Duration(seconds: 0),
        () => Get.find<ShuttleBusController>().setIsLoading(false));
  }

  getShuttleList() async {
    Get.put(ShuttleBusController());
    Get.find<ShuttleBusController>().setShuttleList([]);
    Get.find<ShuttleBusController>().setShuttleList(await fetchShuttleList());
  }
}
