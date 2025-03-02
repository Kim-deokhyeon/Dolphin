import 'package:http/http.dart' as http;

const BASE_URL = 'x4hvqlt6g5.execute-api.ap-northeast-2.amazonaws.com';
const DEV_URL = 'pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com';

const PATH = const {
  'CALENDAR': '/calendar',
  'LATEST_CALENDAR': '/calendar/latest',
  'NOTICES': '/notices',
  'HOLIDAY': '/holiday',
  'BUS_190': '/businfo',
  'SHUTTLE_NEXT': '/shuttle/next',
  'SHUTTLE_LIST': '/shuttle/today',
  'SHUTTLE_ALL': '/timetable/shuttle',
  'DEPART_190': '/timetable/190',
  'WEATHER': '/weather/now',
  // 'MEAL': '/diet/society/today',
  'MEAL': '/diet/v2/society/today',
  'MEAL2': '/diet/naval/today',
  'MEAL3': '/diet/dorm/today',
};

class FetchAPI {
  Future fetchData(path, {queryParameters}) async {
    try {
      var url = Uri.https(BASE_URL, '/prod$path', queryParameters);
      var response = await http.get(url);
      return response;
    } catch (error) {
      print('$error');
    }
  }

  // Future fetchDevData(path, {queryParameters}) async {
  //   try {
  //     var url = Uri.https(DEV_URL, '/dev$path', queryParameters);
  //     var response = await http.get(url);
  //     return response;
  //   } catch (error) {
  //     print('$error');
  //   }
  // }

  Future fetchCityBusInfo(bstopid) async {
    var response = await fetchData('${PATH['BUS_190']}/${bstopid.trim()}');
    return response;
  }

  Future fetchCityBusList() async {
    var response = await fetchData(PATH['BUS_190']);
    return response;
  }

  Future fetchNextDepartCityBus() async {
    var response = await fetchData(PATH['DEPART_190']);
    return response;
  }

  Future fetchNextShuttle() async {
    var response = await fetchData(PATH['SHUTTLE_NEXT']);
    return response;
  }

  Future fetchShuttleList() async {
    var response = await fetchData(PATH['SHUTTLE_LIST']);
    return response;
  }

  Future fetchSchoolNotice() async {
    var response = await fetchData(PATH['NOTICES']);
    return response;
  }

  Future fetchHoliday() async {
    var response = await fetchData(PATH['HOLIDAY']);
    return response;
  }

  Future fetchCalendar() async {
    var response = await fetchData(PATH['CALENDAR']);
    return response;
  }

  Future fetchLatestCalendar() async {
    var response = await fetchData(PATH['LATEST_CALENDAR']);
    return response;
  }

  Future fetchWeather() async {
    var response = await fetchData(PATH['WEATHER']);
    return response;
  }

  Future fetchSocietyTable() async {
    var response = await fetchData(PATH['MEAL']);
    return response;
  }

  Future fetchNavyTable() async {
    var response = await fetchData(PATH['MEAL2']);
    return response;
  }

  Future fetchDormTable() async {
    var response = await fetchData(PATH['MEAL3']);
    return response;
  }
}
