import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_data_source.dart';
import 'package:utc_flutter_app/response/passenger_confirm_details_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class BookingHistoryDetailProvider extends ChangeNotifier{

  double totalAmount = 0;
  String from = "";
  List<TicketDeatil> ticketDeatils = [];
  List<TicketFare> ticketFare = [];
  List<TicketTax> taxes = [];

  PassengerConfirmDetailsResponse passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse();
  PassengerConfirmDetailsDataSource passengerConfirmDetailsDataSource = PassengerConfirmDetailsDataSource();
  Future<PassengerConfirmDetailsResponse> getPassengerConfirmationDetails(String ticketNumber) async {
    var response = await passengerConfirmDetailsDataSource.passengerConfirmDetailsApi(ticketNumber,AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse.fromJson(response);
    if(passengerConfirmDetailsResponse.code=="100"){
      ticketDeatils = passengerConfirmDetailsResponse.ticketDeatil!;
      ticketFare = passengerConfirmDetailsResponse.ticketFare!;
      taxes = passengerConfirmDetailsResponse.ticketTax!;
      totalAmount = passengerConfirmDetailsResponse.ticketFare![0].netfare!.toDouble();
    }

    return passengerConfirmDetailsResponse;
  }

  bool _isLoading = true;
  get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }


  checkTicketStatusColor(String ticketStatus){
    if(ticketStatus=="CONFIRMED"){
      return HexColor(MyColors.green);
    }else {
      return HexColor(MyColors.redColor);
    }

  }


  checkTicketStatus(String ticketStatus){
    if(ticketStatus=="CONFIRMED"){
      return "Amount Paid";
    }else {
      return "Amount";
    }

  }

  checkTicketStatusForColor(String ticketStatus){
    if(ticketStatus=="CONFIRMED"){
      return HexColor(MyColors.green);
    }else {
      return HexColor(MyColors.redColor);
    }

  }

  // checkTicketStatus(){
  //   if(ticketFare[0].currentStatus=="A"){
  //     return "Confirmed";
  //   }else if(ticketFare[0].currentStatus=="C"){
  //     return "Cancelled";
  //   }else if(ticketFare[0].currentStatus=="R"){
  //     return "Requested";
  //   }else if(ticketFare[0].currentStatus=="S"){
  //     return "Suspended";
  //   }
  // }

}