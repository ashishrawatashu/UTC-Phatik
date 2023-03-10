import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/busServiceTypeDataSource/bus_service_type_data_source.dart';
import 'package:utc_flutter_app/dataSource/searchBuses/search_buses_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/bus_service_type_model.dart';
import 'package:utc_flutter_app/response/bus_service_type_response.dart';
import 'package:utc_flutter_app/response/search_services_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class SearchBusProvider extends ChangeNotifier {
  int cheapestFirstValue = 0;
  int lateDepartureValue = 0;
  int earlyDepartureValue = 0;

  bool morningBuses_depature = false;
  bool afterNoonBuses_depature = false;
  bool eveBuses_depature = false;
  bool nightBuses_depature = false;

  bool morningBuses_arrival = false;
  bool afterNoonBuses_arrival = false;
  bool eveBuses_arrival = false;
  bool nightBuses_arrival = false;
  List<String> amenitiesUrlList = [];
  clearFilter() {
    cheapestFirstValue = 0;
    lateDepartureValue = 0;
    earlyDepartureValue = 0;

    morningBuses_depature = false;
    afterNoonBuses_depature = false;
    eveBuses_depature = false;
    nightBuses_depature = false;

    morningBuses_arrival = false;
    afterNoonBuses_arrival = false;
    eveBuses_arrival = false;
    nightBuses_arrival = false;
    for (int i = 0; i < busServices.length; i++) {
      filterBusServices[i].showHideItem = true;
    }

    for (int i = 0; i < newBusTypeModelList.length; i++) {
      newBusTypeModelList[i].isSelected = false;
    }
    notifyListeners();
  }

  splitBusAmenities(String amenities) {
    amenitiesUrlList.clear();
    List<String> result = amenities.split(',');
    for (int i = 0; i < result.length; i++) {
      amenitiesUrlList.add(AppConstants.AMINITIES_URL + result[i].toString());
    }

    return amenitiesUrlList;
  }

  applyFilter() {

    filterBuServiceType();

    notifyListeners();
  }


  setValueInRadioButton(String value, String from) {
    if (from == "Cheap") {
      if (value == "0") {
        cheapestFirstValue = 1;
        lateDepartureValue = 0;
        earlyDepartureValue = 0;
      } else {
        cheapestFirstValue = 0;
      }
    } else if (from == "Early") {
      if (value == "0") {
        earlyDepartureValue = 1;
        cheapestFirstValue = 0;
        lateDepartureValue = 0;
      } else {
        earlyDepartureValue = 0;
      }
    } else if (from == "Late") {
      if (value == "0") {
        lateDepartureValue = 1;
        earlyDepartureValue = 0;
        cheapestFirstValue = 0;
      } else {
        lateDepartureValue = 0;
      }
    }

    notifyListeners();
  }

  checkColorMorningBusDeparture() {
    if (morningBuses_depature == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectMorningBusDeparture() {
    if (morningBuses_depature == false) {
      morningBuses_depature = true;
    } else {
      morningBuses_depature = false;
    }

    notifyListeners();
  }

  checkColorAfterNoonBusDeparture() {
    if (afterNoonBuses_depature == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectAfterNoonBusDeparture() {
    if (afterNoonBuses_depature == false) {
      afterNoonBuses_depature = true;
    } else {
      afterNoonBuses_depature = false;
    }

    notifyListeners();
  }

  checkColorEveningBusDeparture() {
    if (eveBuses_depature == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectEveningBusDeparture() {
    if (eveBuses_depature == false) {
      eveBuses_depature = true;
    } else {
      eveBuses_depature = false;
    }

    notifyListeners();
  }

  checkColorNightBusDeparture() {
    if (nightBuses_depature == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectNightBusDeparture() {
    if (nightBuses_depature == false) {
      nightBuses_depature = true;
    } else {
      nightBuses_depature = false;
    }

    notifyListeners();
  }

  checkColorMorningBusArrival() {
    if (morningBuses_arrival == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectMorningBusArrival() {
    if (morningBuses_arrival == false) {
      morningBuses_arrival = true;
    } else {
      morningBuses_arrival = false;
    }

    notifyListeners();
  }

  checkColorAfterNoonBusArrival() {
    if (afterNoonBuses_arrival == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectAfterNoonBusArrival() {
    if (afterNoonBuses_arrival == false) {
      afterNoonBuses_arrival = true;
    } else {
      afterNoonBuses_arrival = false;
    }

    notifyListeners();
  }

  checkColorEveningBusArrival() {
    if (eveBuses_arrival == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectEveningBusArrival() {
    if (eveBuses_arrival == false) {
      eveBuses_arrival = true;
    } else {
      eveBuses_arrival = false;
    }

    notifyListeners();
  }

  checkColorNightBusArrival() {
    if (nightBuses_arrival == false) {
      return HexColor(MyColors.iconColors);
    } else {
      return HexColor(MyColors.primaryColor);
    }
  }

  selectNightBusArrival() {
    if (nightBuses_arrival == false) {
      nightBuses_arrival = true;
    } else {
      nightBuses_arrival = false;
    }

    notifyListeners();
  }

  SearchBusesDataSource getSearchBusesDataSource = SearchBusesDataSource();
  List<BusServiceTypeModel> busTypeModelList = [];
  List<BusServiceTypeModel> newBusTypeModelList = [];
  List<Services> busServices = [];
  List<Services> filterBusServices = [];
  List<Services> filterForService = [];
  Future<SearchServicesResponse> getSearchBuses(String fromStationName, String toStationName, String serviceTypeId, String date, BuildContext context) async {
    setloading(true);
    busServices.clear();
    filterBusServices.clear();
    //print(filterBusServices.length.toString()+"LENGTH_OF_LIT");
    var response = await getSearchBusesDataSource.getSearchBusesApi(
        fromStationName,
        toStationName,
        serviceTypeId,
        date,
        AppConstants.IS_APP_ACTIVE_TOKEN);
    //print(response);
    SearchServicesResponse searchServicesResponse =
        SearchServicesResponse.fromJson(response);
    if (searchServicesResponse.code == "100") {
      busServices = searchServicesResponse.services!;
      filterBusServices = searchServicesResponse.services!;
      await setServiceTypeInList(searchServicesResponse.services!);
      setFilterBusServicesDataByFilter();
    } else if (searchServicesResponse.code == "101") {
      busServices.clear();
      filterBusServices.clear();
    }else if  (searchServicesResponse.code == "900") {
      CommonMethods.showErrorDialog(context, "Something went wrong !");
    }

    setloading(false);

    return searchServicesResponse;
  }

  setFilterBusServicesDataByFilter() {
    for (int i = 0; i < busServices.length; i++) {
      filterBusServices[i].showHideItem = true;
      busServices[i].showHideItem = true;

      //departure

      if (busServices[i].depttime!.substring(busServices[i].depttime!.length - 2, busServices[i].depttime!.length) == "AM") {
        if (int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 12 &&
            int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 5) {
          filterBusServices[i].deptBus = "Night";
          busServices[i].deptBus = "Night";
        }
        if (int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 11 &&
            int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) >= 6) {
          filterBusServices[i].deptBus = "Morning";
          busServices[i].deptBus = "Morning";
        }
      }
      if (busServices[i].depttime!.substring(busServices[i].depttime!.length - 2, busServices[i].depttime!.length) == "PM") {
        if (int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 12 &&
            int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 4) {
          filterBusServices[i].deptBus = "Afternoon";
          busServices[i].deptBus = "Afternoon";
        }
        if (int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) <= 11 &&
            int.parse(busServices[i].depttime!.substring(0, busServices[i].depttime!.length - 6)) >=  6) {
          filterBusServices[i].deptBus = "Evening";
          busServices[i].deptBus = "Evening";
        }
      }

      //arrival time

      if (busServices[i].arrtime!.substring(busServices[i].arrtime!.length - 2, busServices[i].arrtime!.length) == "AM") {
        if (int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 12 &&
            int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 5) {
          filterBusServices[i].arrivalBus = "Night";
          busServices[i].arrivalBus = "Night";
        }
        if (int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 11 &&
            int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) >= 6) {
          filterBusServices[i].arrivalBus = "Morning";
          busServices[i].arrivalBus = "Morning";
        }
      }
      if (busServices[i].arrtime!.substring(busServices[i].arrtime!.length - 2, busServices[i].arrtime!.length) == "PM") {
        if (int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 12 &&
            int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 4) {
          filterBusServices[i].arrivalBus = "Afternoon";
          busServices[i].arrivalBus = "Afternoon";
        }
        if (int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) <= 11 &&
            int.parse(busServices[i].arrtime!.substring(0, busServices[i].arrtime!.length - 6)) >= 6) {
          filterBusServices[i].arrivalBus = "Evening";
          busServices[i].arrivalBus = "Evening";
        }
      }
    }

    applyFilter();
    clearFilter();
    notifyListeners();
  }

  bool _isloading = true;

  get isloading => _isloading;

  setloading(bool boolvalue) {
    _isloading = boolvalue;
    notifyListeners();
  }

  setServiceTypeInList(List<Services> services) {
    busTypeModelList.clear();
    newBusTypeModelList.clear();
    //print(services.length.toString());
    for (int i = 0; i < services.length; i++) {
      BusServiceTypeModel busServiceTypeModel = BusServiceTypeModel();
      busServiceTypeModel.serviceTypeName = services[i].servicetypename;
      busServiceTypeModel.isSelected = false;
      busTypeModelList.add(busServiceTypeModel);
    }
    busTypeModelList.forEach((element) {
      newBusTypeModelList
          .removeWhere((e) => element.serviceTypeName == e.serviceTypeName);
      newBusTypeModelList.add(element);
    });
  }

  selectServiceType(int index, bool value) {
    for(int  i =0; i< newBusTypeModelList.length;i++){
      if(newBusTypeModelList[index].serviceTypeName==newBusTypeModelList[i].serviceTypeName){
        if (newBusTypeModelList[i].isSelected == null) {
          newBusTypeModelList[i].isSelected = true;
        } else if (newBusTypeModelList[i].isSelected == false) {
          newBusTypeModelList[i].isSelected = true;
        } else {
          newBusTypeModelList[i].isSelected = false;
        }
      }else {
        newBusTypeModelList[i].isSelected = false;
      }
    }


    notifyListeners();
  }

  setValueInServiveTypeCheckBox(int index) {
    if (newBusTypeModelList[index].isSelected == null) {
      return false;
    } else if (newBusTypeModelList[index].isSelected == false) {
      return false;
    } else if (newBusTypeModelList[index].isSelected == true) {
      return true;
    }
  }

  AuthenticationMethodDataSource authenticationMethodDataSource = AuthenticationMethodDataSource();
  AuthenticationMethodResponse authenticationMethodResponse = AuthenticationMethodResponse();

  Future<AuthenticationMethodResponse> authenticationMethod() async {
    var response = await authenticationMethodDataSource.authenticationMethod(AppConstants.AUTH_USER_ID, AppConstants.AUTH_IMEI);
    //print(response);
    authenticationMethodResponse = AuthenticationMethodResponse.fromJson(response);
    if (authenticationMethodResponse.code == "100") {
      AppConstants.MY_TOKEN = authenticationMethodResponse.result![0].token.toString();
    }
    return authenticationMethodResponse;
  }

  BusServiceTypeDataSource busServiceTypeDataSource = BusServiceTypeDataSource();
  BusServiceTypeResponse busServiceTypeResponse = BusServiceTypeResponse();

  Future<BusServiceTypeResponse> busServiceTypeRequest(String strpId,BuildContext context) async {
    var response = await busServiceTypeDataSource.busServiceTypeApi(strpId, AppConstants.MY_TOKEN);
    busServiceTypeResponse = BusServiceTypeResponse.fromJson(response);
    return busServiceTypeResponse;
  }






  void filterBuServiceType() {
    String serviceType = "";
    List<String>  totalCount = [];
    for (int i = 0; i < newBusTypeModelList.length; i++) {
      if (newBusTypeModelList[i].isSelected == true) {
        serviceType = newBusTypeModelList[i].serviceTypeName.toString();
        for (int k = 0; k < busServices.length; k++) {
          if (serviceType.toString().trim().compareTo(busServices[k].servicetypename.toString().trim()) == 0) {
            filterBusServices[k].showHideItem = true;
          }else {
            filterBusServices[k].showHideItem = false;
          }
        }
      }else{
        totalCount.add("Check");
        if(totalCount.length==newBusTypeModelList.length){
          for (int k = 0; k < busServices.length; k++) {
            filterBusServices[k].showHideItem = true;
          }
        }
      }
    }

    checkForTimeWiseFiter();

    if (cheapestFirstValue == 1) {
      filterBusServices.sort((a, b) => a.totalfare!.compareTo(b.totalfare!));
    }



  }

  void filterBySortBy() {
    for (int i = 0; i < filterBusServices.length; i++) {
      if (filterBusServices[i].showHideItem == true) {
        if (lateDepartureValue == 1 && busServices[i].deptBus == "Night" ||
            earlyDepartureValue == 1 && busServices[i].deptBus == "Morning" ||
            nightBuses_depature == true && busServices[i].deptBus == "Night" ||
            afterNoonBuses_depature == true && busServices[i].deptBus == "Afternoon" ||
            morningBuses_depature == true && busServices[i].deptBus == "Morning" ||
            eveBuses_depature == true && busServices[i].deptBus == "Evening" ||
            nightBuses_arrival == true && busServices[i].arrivalBus == "Night" ||
            afterNoonBuses_arrival == true && busServices[i].arrivalBus == "Afternoon" ||
            morningBuses_arrival == true && busServices[i].arrivalBus == "Morning" ||
            eveBuses_arrival == true && busServices[i].arrivalBus == "Evening") {
          filterBusServices[i].showHideItem = true;
        } else if (lateDepartureValue == 0 &&
            earlyDepartureValue == 0 &&
            nightBuses_depature == false &&
            afterNoonBuses_depature == false &&
            morningBuses_depature == false &&
            eveBuses_depature == false &&
            nightBuses_arrival == false &&
            afterNoonBuses_arrival == false &&
            morningBuses_arrival == false &&
            eveBuses_arrival == false) {
          filterBusServices[i].showHideItem = true;
        } else {
          filterBusServices[i].showHideItem = false;
        }
      }
      else {
        //print("zzzzzz");
        for (int i = 0; i < busServices.length; i++) {
          if (lateDepartureValue == 1 && busServices[i].deptBus == "Night" ||
              earlyDepartureValue == 1 && busServices[i].deptBus == "Morning" ||
              nightBuses_depature == true &&
                  busServices[i].deptBus == "Night" ||
              afterNoonBuses_depature == true &&
                  busServices[i].deptBus == "Afternoon" ||
              morningBuses_depature == true &&
                  busServices[i].deptBus == "Morning" ||
              eveBuses_depature == true &&
                  busServices[i].deptBus == "Evening" ||
              nightBuses_arrival == true &&
                  busServices[i].arrivalBus == "Night" ||
              afterNoonBuses_arrival == true &&
                  busServices[i].arrivalBus == "Afternoon" ||
              morningBuses_arrival == true &&
                  busServices[i].arrivalBus == "Morning" ||
              eveBuses_arrival == true &&
                  busServices[i].arrivalBus == "Evening") {
            filterBusServices[i].showHideItem = true;
          } else if (lateDepartureValue == 0 &&
              earlyDepartureValue == 0 &&
              nightBuses_depature == false &&
              afterNoonBuses_depature == false &&
              morningBuses_depature == false &&
              eveBuses_depature == false &&
              nightBuses_arrival == false &&
              afterNoonBuses_arrival == false &&
              morningBuses_arrival == false &&
              eveBuses_arrival == false) {
            filterBusServices[i].showHideItem = true;
          } else {
            filterBusServices[i].showHideItem = false;
          }
        }
      }
    }

  }

  void checkForTimeWiseFiter() {
    for (int i = 0; i < filterBusServices.length; i++) {
      if (lateDepartureValue == 1 && filterBusServices[i].deptBus == "Night" || earlyDepartureValue == 1 && filterBusServices[i].deptBus == "Morning" ||
          nightBuses_depature == true &&
              filterBusServices[i].deptBus == "Night" ||
          afterNoonBuses_depature == true &&
              filterBusServices[i].deptBus == "Afternoon" ||
          morningBuses_depature == true &&
              filterBusServices[i].deptBus == "Morning" ||
          eveBuses_depature == true &&
              filterBusServices[i].deptBus == "Evening" ||
          nightBuses_arrival == true &&
              filterBusServices[i].arrivalBus == "Night" ||
          afterNoonBuses_arrival == true &&
              filterBusServices[i].arrivalBus == "Afternoon" ||
          morningBuses_arrival == true &&
              filterBusServices[i].arrivalBus == "Morning" ||
          eveBuses_arrival == true &&
              filterBusServices[i].arrivalBus == "Evening") {
        if(filterBusServices[i].showHideItem==true){
          filterBusServices[i].showHideItem = true;
        }
      } else if (lateDepartureValue == 0 &&
          earlyDepartureValue == 0 &&
          nightBuses_depature == false &&
          afterNoonBuses_depature == false &&
          morningBuses_depature == false &&
          eveBuses_depature == false &&
          nightBuses_arrival == false &&
          afterNoonBuses_arrival == false &&
          morningBuses_arrival == false &&
          eveBuses_arrival == false) {
        if(filterBusServices[i].showHideItem==true){
          filterBusServices[i].showHideItem = true;
        }
      } else {
        filterBusServices[i].showHideItem = false;
      }
    }
  }
}
