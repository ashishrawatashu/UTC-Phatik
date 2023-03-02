import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/seatLayoutBoarding/seat_layout_boarding_data_source.dart';
import 'package:utc_flutter_app/response/Bus_seat_ll.dart';
import 'package:utc_flutter_app/response/passenger_information_pojo.dart';
import 'package:utc_flutter_app/response/seat_layout_boarding_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';

class BusSeatLayoutProvider extends ChangeNotifier{

  String dsvcId = "", strpId= "", fromStationId="", toStationId = "", bordeingStationId = "",tripType ="";
  List<PassengerInformationPojo> passengerList = [];
  List<String> amenitiesUrlList = [];

  int maxSeat = 0;

  selectSeatText(){
    if(maxSeat==0){
      return "Select seats";
    }else {
      return  "Seats No.s: ";
    }
  }

  List<Bus_seat_ll> mainnlistresponse = [];
  List<Bus_seat_ll> getSeatLayout(){
    List<dynamic> busSeatLayoutList = json.decode('[{ "ROWNUMBER": 1.0, "COLNUMBER": 1.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 1.0, "COLNUMBER": 2.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 1.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 1.0, "COLNUMBER": 4.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 1.0, "COLNUMBER": 5.0, "SEATNO": 0.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "D", "SEATAVAILFORONLBOOKING": "N", "STATUS": null }, { "ROWNUMBER": 2.0, "COLNUMBER": 1.0, "SEATNO": 1.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "C", "SEATAVAILFORONLBOOKING": "N", "STATUS": null }, { "ROWNUMBER": 2.0, "COLNUMBER": 2.0, "SEATNO": 2.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "M", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 2.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 2.0, "COLNUMBER": 4.0, "SEATNO": 3.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 2.0, "COLNUMBER": 5.0, "SEATNO": 4.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 3.0, "COLNUMBER": 1.0, "SEATNO": 5.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 3.0, "COLNUMBER": 2.0, "SEATNO": 6.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 3.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 3.0, "COLNUMBER": 4.0, "SEATNO": 7.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 3.0, "COLNUMBER": 5.0, "SEATNO": 8.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 4.0, "COLNUMBER": 1.0, "SEATNO": 9.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 4.0, "COLNUMBER": 2.0, "SEATNO": 10.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 4.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 4.0, "COLNUMBER": 4.0, "SEATNO": 11.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 4.0, "COLNUMBER": 5.0, "SEATNO": 12.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 5.0, "COLNUMBER": 1.0, "SEATNO": 13.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 5.0, "COLNUMBER": 2.0, "SEATNO": 14.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 5.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 5.0, "COLNUMBER": 4.0, "SEATNO": 15.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 5.0, "COLNUMBER": 5.0, "SEATNO": 16.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 6.0, "COLNUMBER": 1.0, "SEATNO": 17.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 6.0, "COLNUMBER": 2.0, "SEATNO": 18.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 6.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 6.0, "COLNUMBER": 4.0, "SEATNO": 19.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 6.0, "COLNUMBER": 5.0, "SEATNO": 20.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 7.0, "COLNUMBER": 1.0, "SEATNO": 21.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 7.0, "COLNUMBER": 2.0, "SEATNO": 22.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 7.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 7.0, "COLNUMBER": 4.0, "SEATNO": 23.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 7.0, "COLNUMBER": 5.0, "SEATNO": 24.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 8.0, "COLNUMBER": 1.0, "SEATNO": 25.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 8.0, "COLNUMBER": 2.0, "SEATNO": 26.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 8.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 8.0, "COLNUMBER": 4.0, "SEATNO": 27.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 8.0, "COLNUMBER": 5.0, "SEATNO": 28.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 9.0, "COLNUMBER": 1.0, "SEATNO": 29.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 9.0, "COLNUMBER": 2.0, "SEATNO": 30.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 9.0, "COLNUMBER": 3.0, "SEATNO": 0.0, "SEATYN": "N", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 9.0, "COLNUMBER": 4.0, "SEATNO": 31.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 9.0, "COLNUMBER": 5.0, "SEATNO": 32.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 10.0, "COLNUMBER": 1.0, "SEATNO": 33.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 10.0, "COLNUMBER": 2.0, "SEATNO": 34.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 10.0, "COLNUMBER": 3.0, "SEATNO": 35.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 10.0, "COLNUMBER": 4.0, "SEATNO": 36.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }, { "ROWNUMBER": 10.0, "COLNUMBER": 5.0, "SEATNO": 37.0, "SEATYN": "Y", "TRAVELLERTYPECODE": "G", "SEATAVAILFORONLBOOKING": "Y", "STATUS": null }]');

    mainnlistresponse = fetchPosts(busSeatLayoutList);
    notifyListeners();
    return mainnlistresponse;

  }


  SeatLayoutBoardingDataSource seatLayoutBoardingDataSource = SeatLayoutBoardingDataSource();
  SeatLayouLboardingResponse seatLayouLboardingResponse = SeatLayouLboardingResponse();
  List<LowerLayout> lowerSeatList = [];
  List<UpperLayout> upperSeatLayout = [];
  List<Boarding> boardingList = [];

  Future<SeatLayouLboardingResponse> getSeatLayoutBoardingResponse(String dsvcId, String journeyDate, String strpId, String toStationId, BuildContext context) async {
    setLoading(true);
    var response = await seatLayoutBoardingDataSource.getSeatLayoutBoardingApi(dsvcId, journeyDate, strpId, toStationId,AppConstants.MY_TOKEN);
    //print(response);
    seatLayouLboardingResponse = SeatLayouLboardingResponse.fromJson(response);
    if(seatLayouLboardingResponse.code=="100"){
      if(seatLayouLboardingResponse.lowerLayout!.isEmpty){
        Navigator.pop(context);
        CommonMethods.showSnackBar(context, "Something went wrong, please try again");
      }else{
        lowerSeatList = seatLayouLboardingResponse.lowerLayout!;
        upperSeatLayout = seatLayouLboardingResponse.upperLayout!;
        boardingList = seatLayouLboardingResponse.boarding!;
        if(boardingList.isEmpty){
          CommonMethods.showErrorMoveToDashBaordDialog(context, "No boarding sation !");
        }
        //print(boardingList.length.toString()+"BOARDING");
        //print(boardingList.length.toString());
      }
    }else  if(seatLayouLboardingResponse.code=="900"){
      CommonMethods.showErrorDialog(context, "Something went wrong, please try again");
    }else if(seatLayouLboardingResponse.code=="999"){
      CommonMethods.showTokenExpireDialog(context);
    }else {
      CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again");
    }
    setLoading(false);

    return seatLayouLboardingResponse;

  }

  bool _isLoading = true;
  get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  setLayoutInLowerBirth(int index) {
    if (index == 1 || index == 5 || index == 9 || index == 13 || index == 17) {
      return false;
    } else {
      return true;
    }

  }



  getVisibilityOfSeats(int index) {
    for (int i = 0; i < lowerSeatList.length; i++) {
      if (lowerSeatList[index].travellertypecode == "G" && lowerSeatList[index].seatyn == "N") {
        return false;
      } else {
        return true;
      }

    }
  }


  setImageOnSelectSeat(int index){
    for (int i = 0; i < lowerSeatList.length; i++) {
      if (lowerSeatList[index].travellertypecode == "D") {
        return "assets/images/driver.png";
      }
      if (lowerSeatList[index].travellertypecode == "C") {
        return "assets/images/seatconductorn.png";
      }

      if (lowerSeatList[index].seatavailforonlbooking == "N") {
        return "assets/images/seatgray.png";
      }

      if (lowerSeatList[index].status == "A"&&lowerSeatList[index].seatavailforonlbooking=="Y") {
           lowerSeatList[index].isBlocked = true;
           return "assets/images/seatgray.png";
      }else if(lowerSeatList[index].status == null){
        lowerSeatList[index].isBlocked = false;
      }

      if (lowerSeatList[index].travellertypecode == "F"||lowerSeatList[index].travellertypecode == "M"||lowerSeatList[index].travellertypecode == "G"&&lowerSeatList[index].seatavailforonlbooking == "Y"&&lowerSeatList[index].isBlocked==false||lowerSeatList[index].status == null) {
          if(lowerSeatList[index].isSelected==true){
            return "assets/images/seatbluee.png";
          }else if(lowerSeatList[index].isSelected==null){
            if(lowerSeatList[index].travellertypecode == "F"){
              return "assets/images/seatpink.png";
            }else if(lowerSeatList[index].travellertypecode == "M"){
              return "assets/images/seatgreen.png";
            }else {
              return "assets/images/seatwhitee.png";
            }
          }else{
            if(lowerSeatList[index].travellertypecode == "F"){
              return "assets/images/seatpink.png";
            }else if(lowerSeatList[index].travellertypecode == "M"){
              return "assets/images/seatgreen.png";
            }else {
              return "assets/images/seatwhitee.png";
            }
          }
      }

    }

    notifyListeners();

  }

  concatSeatsNumber(){
    String totalSeatsCount ="";
    passengerList.clear();
    for(int i=0;i<lowerSeatList.length;i++){
      PassengerInformationPojo passengerInformationPojo = PassengerInformationPojo();
      if(lowerSeatList[i].isSelected==true&&lowerSeatList[i].isBlocked == false){
        String? travellertypecode = lowerSeatList[i].travellertypecode;
        if(travellertypecode=="M"){
          passengerInformationPojo.seatNo = lowerSeatList[i].seatno.toString();
          passengerInformationPojo.name = "";
          passengerInformationPojo.gender = "M";
          passengerInformationPojo.age = "";
          passengerInformationPojo.onlyMale = "Y";
          passengerInformationPojo.genderName = "Male";

        }else if(travellertypecode=="F"){
          passengerInformationPojo.seatNo = lowerSeatList[i].seatno.toString();
          passengerInformationPojo.name = "";
          passengerInformationPojo.gender = "F";
          passengerInformationPojo.age = "";
          passengerInformationPojo.onlyMale = "Y";
          passengerInformationPojo.genderName = "Female";

        }else {
          passengerInformationPojo.seatNo = lowerSeatList[i].seatno.toString();
          passengerInformationPojo.name = "";
          passengerInformationPojo.gender = travellertypecode;
          passengerInformationPojo.age = "";
          passengerInformationPojo.onlyMale = "N";
          passengerInformationPojo.genderName = null;
        }

        passengerList.add(passengerInformationPojo);

        totalSeatsCount = totalSeatsCount+"," + lowerSeatList[i].seatno.toString();
      }


    }

    if(totalSeatsCount.length>1){
      return totalSeatsCount.substring(1);
    }else{
      return totalSeatsCount;
    }



  }

  maxSeatCheck(){
    if(maxSeat==AppConstants.MAX_SEAT_SELECT){
      return false;
    }else{
      return true;
    }
  }


  selectDeselectSeats(int index){
    if(lowerSeatList[index].isBlocked==false){
      if(lowerSeatList[index].travellertypecode=="G"||lowerSeatList[index].travellertypecode=="F"||lowerSeatList[index].travellertypecode=="M"&&lowerSeatList[index].seatavailforonlbooking=="Y"){
        if( lowerSeatList[index].isSelected == null){
          if(maxSeat==AppConstants.MAX_SEAT_SELECT){

          }else{
            lowerSeatList[index].isSelected = true;
            maxSeat = maxSeat+1;
          }
        }else if(lowerSeatList[index].isSelected == true){
          lowerSeatList[index].isSelected = false;
          maxSeat = maxSeat-1;
        }else if(lowerSeatList[index].isSelected == false){
          if(maxSeat==AppConstants.MAX_SEAT_SELECT){

          }else{
            lowerSeatList[index].isSelected = true;
            maxSeat = maxSeat+1;
          }
        }
      }
    }



    notifyListeners();
  }

  List<Bus_seat_ll> fetchPosts(dynamic response) {
    return (response as List)
        .map((p) => Bus_seat_ll.fromJson(p))
        .toList();
  }

}