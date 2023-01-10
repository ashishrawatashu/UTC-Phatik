import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utc_flutter_app/arguments/stations_screen_arguments.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/getDashboardData/get_dashboard_data_source.dart';
import 'package:utc_flutter_app/response/get_dashboard_response.dart';
import 'package:utc_flutter_app/response/recent_searches_data.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'package:utc_flutter_app/utils/sharedpref/memory_management.dart';

class HomeTabProvider extends ChangeNotifier {
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();

  String? isSkip;
  String dateForJourney1 = "Select Date";
  String services = "All";
  String helpPhoneNo = "";
  String helpEmailId = "";
  bool hitFirstTime = false;
  String userRecentData = "";
  String dashBoardDate = "";
  List<RecentSearchesData> recentSearchData1 = [];
  List<RecentSearchesData> recentSearchData = [];
  // List<Alert> allAlerts = [];
  late DateTime selectedDateTime;
  bool checkDateTime = false;
  String loginDateTime = "";

  getLoginDateTime() async {
    await encryptedSharedPreferences
        .getString(StringsFile.loginDateTime)
        .then((String value) {
      loginDateTime = value;

      /// Prints Hello, World!
    });
  }

  setDateINCal() {
    if (checkDateTime == false) {
      selectedDateTime = DateTime.now();
      return selectedDateTime;
    } else {
      return selectedDateTime;
    }
  }

  setDateTime(DateTime dateTime, bool firstTime) {
    checkDateTime = firstTime;
    if (checkDateTime == false) {
      selectedDateTime = DateTime.now();
    } else {
      selectedDateTime = dateTime;
    }
  }

  getPhoneNumber() async {
    await encryptedSharedPreferences
        .getString(StringsFile.phoneNumber)
        .then((String value) {
      //print(value + "PHONE NUMBER");
      AppConstants.USER_MOBILE_NO = value;


      /// Prints Hello, World!
    });

    await encryptedSharedPreferences
        .getString(StringsFile.userName)
        .then((String value) {
      //print(value + "USERNAME");
      AppConstants.USER_NAME = value;


      /// Prints Hello, World!
    });
  }

  swap(String source, String destination) {
    AppConstants.SELECTED_DESTINATION = source;
    AppConstants.SELECTED_SOURCE = destination;
    notifyListeners();
  }

  getRecentSearches() {
    recentSearchData1.clear();
    if (MemoryManagement.getRecentData() != null) {
      userRecentData = MemoryManagement.getRecentData()!;
      recentSearchData1 = RecentSearchesData.decode(userRecentData);
      //print(recentSearchData1[0].searchDate.toString()+"SIZE RESENT ");
      notifyListeners();
    }
  }

  setRecentSearches(
      String sourceId,
      destinationId,
      String sourceCityName,
      String destinationCityName,
      String sourceStation,
      String destinationStation,
      String searchDate) {
    // List<RecentSearchesData> setDataInRecentSearches = [];
    // recentSearchData.add(RecentSearchesData(sourceId: sourceId, destinationId: destinationId, sourcecityname: sourceCityName, destinationCityName: destinationCityName, sourceStation: sourceStation, destinationStation: destinationStation, searchDate: searchDate,sourceAndDestination :sourceCityName+destinationCityName));
    if (recentSearchData.length <= 4) {
      recentSearchData.add(RecentSearchesData(
          sourceId: sourceId,
          destinationId: destinationId,
          sourcecityname: sourceCityName,
          destinationCityName: destinationCityName,
          sourceStation: sourceStation,
          destinationStation: destinationStation,
          searchDate: searchDate,
          sourceAndDestination: sourceStation + destinationStation));
    } else {
      recentSearchData.removeAt(0);
      recentSearchData.add(RecentSearchesData(
          sourceId: sourceId,
          destinationId: destinationId,
          sourcecityname: sourceCityName,
          destinationCityName: destinationCityName,
          sourceStation: sourceStation,
          destinationStation: destinationStation,
          searchDate: searchDate,
          sourceAndDestination: sourceStation + destinationStation));
    }
    recentSearchData.forEach((element) {
      recentSearchData1.removeWhere(
          (e) => element.sourceAndDestination == e.sourceAndDestination);
      recentSearchData1.add(element);
    });

    final String encodedData = RecentSearchesData.encode(recentSearchData1);
    MemoryManagement.setRecentData(resendData: encodedData);
  }

  setSourceAndDestinationName(String selectedSource, String selectedDestion) {
    AppConstants.SELECTED_SOURCE = selectedSource;
    AppConstants.SELECTED_DESTINATION = selectedDestion;
    notifyListeners();
  }

  // get  dateForJourney => _dateForJourney;

  setDate(String dateForJourney) {
    AppConstants.JOURNEY_DATE = dateForJourney;
    dateForJourney1 = dateForJourney;
    //print(dateForJourney1.toString() + "fghjkml,");
    notifyListeners();
  }

  // void isSkippedd()  {
  //   isSkip = MemoryManagement.getIsSkipped();
  //   notifyListeners();
  //
  // }

  // void isNotSkippedd(String sss)  {
  //   isSkip = sss;
  //   // if(isSkip=="true"){
  //   //   isSkip = "false";
  //   // }else if (isSkip=="false"){
  //   //   isSkip = "true";
  //   // }
  //   notifyListeners();
  //
  // }

  List<Offers> offers = [];
  // List<PopularRoutes> popularRoutes = [];
  // List<PopularRoutes> filterPopularRoutes = [];
  List<Helpdek> helpDesk = [];
  List<ServiceTypes> serviceTypes = [];
  // List<LastTransactions> lastTransactions = [];
  GetDashboardDataSource getDashboardDataSource = GetDashboardDataSource();
  GetDashboardResponse getDashboardResponse = GetDashboardResponse();

  Future<GetDashboardResponse> getDashboardData(String mobileNo, BuildContext context) async {
    setLoading(true);
    var response = await getDashboardDataSource.getDashboardApi(mobileNo, AppConstants.IS_APP_ACTIVE_TOKEN);
    //print(response);
    getDashboardResponse = GetDashboardResponse.fromJson(response);
    if (getDashboardResponse.code == "100") {
      AppConstants.HIT_FIRST_TIME = true;
      helpDesk = getDashboardResponse.helpdek!;
      serviceTypes = getDashboardResponse.serviceTypes!;
      if(getDashboardResponse.advanceDays!.isEmpty){
        AppConstants.ADVANCE_DAYS_BOOKING = 5;
      }else{
        AppConstants.ADVANCE_DAYS_BOOKING = getDashboardResponse.advanceDays![0].days!;
      }

      if(getDashboardResponse.offers!.isEmpty){
        AppConstants.OFFERS = false;
      }else {
        AppConstants.OFFERS = true;
        offers = getDashboardResponse.offers!;
      }
    }else if (getDashboardResponse.code == "900") {
      CommonMethods.showErrorDialog(context, "Something went wrong. Please try again");

    }
    setLoading(false);

    return getDashboardResponse;
  }

  bool _isLoading = false;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  searchBusValidation() {}

  // selectServiceType(int index) {
  //   services = serviceTypes[index].serviceTypeNameEn!;
  //   AppConstants.SERVICE_TYPE_ID = serviceTypes[index].srtpId.toString();
  //   AppConstants.SERVICE_TYPE_ID = serviceTypes[index].srtpId.toString();
  //   notifyListeners();
  // }


  void source(BuildContext context) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      Navigator.pushNamed(context, MyRoutes.selectPlace, arguments: SearchStationArguments("F"));
      // _cancelTicketsListProvider.getTickets();
    }
    else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  void destination(BuildContext context) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      Navigator.pushNamed(context, MyRoutes.selectPlace, arguments: SearchStationArguments("T"));
      // _cancelTicketsListProvider.getTickets();
    }
    else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

}
