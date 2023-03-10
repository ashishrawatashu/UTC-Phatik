import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/checkConcessionPassDataSource/check_concession_pass_data_source.dart';
import 'package:utc_flutter_app/dataSource/savePassengers/save_passengers_data_source.dart';
import 'package:utc_flutter_app/response/check_concession_pass_response.dart';
import 'package:utc_flutter_app/response/passenger_information_pojo.dart';
import 'package:utc_flutter_app/response/save_passengers_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

import '../../arguments/payment_screen_arguments.dart';
import '../../utils/common_methods.dart';
import '../../utils/my_routes.dart';

class FillConcessionScreenProvider extends ChangeNotifier {
  String depotServiceCode = "",
      tripType = "",
      tripId = "",
      fromStationId = "",
      toStationId = "",
      bordeingStationId = "",
      passengers = "",
      userEmailId = "";
  String ticketNumber = "";
  List<PassengerInformationPojo> passengerList = [];

  concatSeatsNumber() {
    String totalSeatsCount = "";
    for (int i = 0; i < passengerList.length; i++) {
      totalSeatsCount =
          totalSeatsCount + "," + passengerList[i].seatNo.toString();
    }
    if (totalSeatsCount.isEmpty) {
      return totalSeatsCount;
    } else {
      return totalSeatsCount.substring(1);
    }
  }

  checkPassVerificationVisiblility(int index) {
    if (passengerList[index].sponlineverificationyn == "Y") {
      return true;
    } else {
      return false;
    }
  }

  var _busPassNo;

  get busPassNo => _busPassNo;

  void busPassNovalidation(String? busPassNo, int index) {
    if (busPassNo!.isEmpty) {
      _busPassNo = "Invalid pass no !";
      notifyListeners();
    } else {
      _busPassNo = null;
      notifyListeners();
    }
  }

  CheckConcessionPassResponse checkConcessionPassResponse = CheckConcessionPassResponse();
  CheckConcessionPassDataSource checkConcessionPassDataSource = CheckConcessionPassDataSource();
//FF23022402009
  Future<CheckConcessionPassResponse> checkConcessionPass(int index, String concession, String passno, String journeyDate, BuildContext context) async {
    CommonMethods.showLoadingDialog(context);
    passengerList[index].idPassValid = false;
    var response = await checkConcessionPassDataSource.checkConcessionPassApi(concession, passno, journeyDate, AppConstants.MY_TOKEN);
    print(response.toString() + "==>");
    checkConcessionPassResponse = CheckConcessionPassResponse.fromJson(response);
    Navigator.pop(context);
    if (checkConcessionPassResponse.code == "100") {passengerList[index].checkBusPassStatus = checkConcessionPassResponse.concession![0].presult.toString();
      if (checkConcessionPassResponse.concession![0].presult == "Success") {
        CommonMethods.dialogDone(context, "Pass is verified ");
        passengerList[index].idPassValid = true;
      } else if (passengerList[index].checkBusPassStatus == "Error") {
        passengerList[index].idPassValid = false;
        CommonMethods.showSnackBar(context, "Invalid pass no !");
      }
    } else if (checkConcessionPassResponse.code == "999") {
      CommonMethods.showTokenExpireDialog(context);
    } else {
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
    }
    return checkConcessionPassResponse;
  }

  checkDocumentVerification(int index) {
    if (passengerList[index].spdocumentverificationyn == "Y") {
      return true;
    } else {
      return false;
    }
  }

  bool passengerForm = false;

  validatePassNoAndIdProof() {
    passengerForm = false;
    for (int i = 0; i < passengerList.length; i++) {
      if (passengerList[i].passengerPassNoTextEditingController.text == null &&
          passengerList[i].idPassValid == false) {
        print(passengerList[i].passengerPassNoTextEditingController.text);
        print(passengerList[i].idPassValid);
        if (passengerList[i].sponlineverificationyn == "Y") {
          print("HELLO1");
          passengerForm = false;
        }
      } else {
        //print("HELLO");
        if (passengerList[i].sponlineverificationyn == "Y") {
          if (passengerList[i].idPassValid == true) {
            passengerForm = true;
          } else {
            print("HELLO3");
            passengerForm = false;
          }
        } else {
          print("HELLO");
          passengerForm = true;
        }
      }
    }
    notifyListeners();
  }

// seatno, name, gender , age , concessionId, journet type, fare=0, onlineverficationYN, passno, Id verificationYN, Id verfication , documnetverifucation VN, documentverfication
  concatPassengersListToString() {
    passengers = "";
    for (int i = 0; i < passengerList.length; i++) {
      if (passengerList.length == 1) {
        passengers = passengerList[i].seatNo.toString() +
            "," +
            passengerList[i].name.toString() +
            "," +
            passengerList[i].gender.toString() +
            "," +
            passengerList[i].age.toString() +
            "," +
            passengerList[i].concessionId.toString() +
            "," +
            tripType +
            ","
                "0" +
            "," +
            passengerList[i].sponlineverificationyn.toString() +
            "," +
            passengerList[i]
                .passengerPassNoTextEditingController
                .text
                .toString() +
            "," +
            passengerList[i].spidverificationyn.toString() +
            "," +
            passengerList[i]
                .passengerIdNoTextEditingController
                .text
                .toString() +
            "," +
            passengerList[i].spdocumentverificationyn.toString() +
            "," +
            passengerList[i].spdocumentverification.toString();
      } else {
        passengers = passengerList[i].seatNo.toString() +
            "," +
            passengerList[i].name.toString() +
            "," +
            passengerList[i].gender.toString() +
            "," +
            passengerList[i].age.toString() +
            "," +
            passengerList[i].concessionId.toString() +
            "," +
            tripType +
            ",""0" +
            "," +
            passengerList[i].sponlineverificationyn.toString() +
            "," +
            passengerList[i].passengerPassNoTextEditingController.text.toString() +
            "," +
            passengerList[i].spidverificationyn.toString() +
            "," +
            passengerList[i].passengerIdNoTextEditingController.text.toString() +
            "," +
            passengerList[i].spdocumentverificationyn.toString() +
            "," +
            passengerList[i].spdocumentverification.toString() +
            "," +
            "|" +
            passengers;
      }
    }
    if (passengerList.length > 1) {
      passengers = passengers.substring(0, passengers.length - 1);
    }

    //print(passengers);

    notifyListeners();
  }

  //save passengers
  SavePassengersResponse savePassengersResponse = SavePassengersResponse();
  SavePassengersDataSource savePassengersDataSource =
      SavePassengersDataSource();

  Future<SavePassengersResponse> savePassengers(BuildContext context) async {
    CommonMethods.showLoadingDialog(context);
    var response = await savePassengersDataSource.savePassengersApi(
        depotServiceCode,
        tripType,
        tripId,
        AppConstants.JOURNEY_DATE,
        fromStationId,
        toStationId,
        "T",
        AppConstants.USER_MOBILE_NO,
        AppConstants.USER_MOBILE_NO,
        userEmailId,
        bordeingStationId,
        passengers,
        AppConstants.DEVICE_ID!,
        AppConstants.MY_TOKEN);
    print(response);
    savePassengersResponse = SavePassengersResponse.fromJson(response);
    Navigator.pop(context);
    if (savePassengersResponse.code == "100") {
      if (savePassengersResponse.result!.isEmpty) {
        CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again later");
      } else {
        ticketNumber = savePassengersResponse.result![0].pTicketnumber.toString();
        moveToPaymentScreen(context);
      }
    } else if (savePassengersResponse.code == "999") {
      CommonMethods.showTokenExpireDialog(context);
    } else {
      CommonMethods.showSnackBar(context, "Something went wrong, please try again later");
    }

    return savePassengersResponse;
  }

  void checkBusPass(int index, BuildContext context) async {
    if (passengerList[index]
        .passengerPassNoTextEditingController
        .text
        .isEmpty) {
      CommonMethods.showSnackBar(context, "Please enter pass number");
      return;
    }

    await checkConcessionPass(index, passengerList[index].concessionId.toString(), passengerList[index].passengerPassNoTextEditingController.text.toString(),AppConstants.JOURNEY_DATE, context);
  }

  void checkConcessionVaidation(BuildContext context) async {
    if (await CommonMethods.getInternetUsingInternetConnectivity()) {
      await validatePassNoAndIdProof();
      if (passengerForm == true) {
        await checkAllPassNoAreNotSame();
        if(uniqueAllPasses==true){
          await concatSeatsNumber();
          await concatPassengersListToString();
          await savePassengers(context);
        }else {
          CommonMethods.showSnackBar(context, "Please verify unique pass no. ");
        }
      } else {
        CommonMethods.showSnackBar(context, "Please check and verify the Id/Bus pass");
      }
    } else {
      CommonMethods.showNoInternetDialog(context);
    }
  }

  moveToPaymentScreen(BuildContext context) {
    if (ticketNumber == "EXCEPTION") {
      CommonMethods.showSnackBar(context, "Something went wrong !");
    } else {
      //print("TICKET-NO===>" + ticketNumber);
      passengerList.clear();
      Navigator.pushNamed(context, MyRoutes.paymentScreen,
          arguments: PaymentScreenArguments(ticketNumber, "PassengersDetails"));
    }
  }

  bool uniqueAllPasses = true;
   checkAllPassNoAreNotSame() {
    List<String> totalPassNo = [];
    for(int index = 0 ;index < passengerList.length;index++) {
      if (passengerList[index].sponlineverificationyn == "Y"&&passengerList[index].idPassValid==true) {
        totalPassNo.add(passengerList[index].passengerPassNoTextEditingController.text.toString());
      }
    }
    List<String> duplicates = totalPassNo;
    print("before $totalPassNo");
    duplicates = duplicates.toSet().toList();
    print("after $duplicates");
    print(duplicates.length);
    print(totalPassNo.length);
    if(totalPassNo.length==duplicates.length){
      uniqueAllPasses =  true;
    }else {
      uniqueAllPasses = false;
    }

    notifyListeners();
  }

  chekPassIsValidOrNot(int index) {
     if(passengerList[index].idPassValid==null||passengerList[index].idPassValid==false){
       return true;
     }else {
       return false;
     }
  }

  checkPassIsVerifedOrNot(int index) {
    if(passengerList[index].idPassValid==null||passengerList[index].idPassValid==false){
      return false;
    }else {
      return true;
    }
  }
}
