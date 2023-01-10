import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/passenger_confirm_details_response.dart';

import '../../dataSource/getActivTicketsDataSource/get_active_tickets_data_source.dart';
import '../../dataSource/getQRTextEnDataSource/get_qr_text_en_data_source.dart';
import '../../dataSource/passengerConfirmDetails/passenger_confirm_details_data_source.dart';
import '../../response/get_active_tickets_response.dart';
import '../../response/get_qr_text_en_response.dart';
import '../../utils/app_constants.dart';

class ActiveBookingScreenProvider extends ChangeNotifier {


  GetActiveTicketsResponse getActiveTicketsResponse = GetActiveTicketsResponse();
  GetActiveTicketsDataSource getActiveTicketsDataSource = GetActiveTicketsDataSource();
  List<Ticket> getAllTickets = [];

  Future<GetActiveTicketsResponse> getConfirmsTickets()  async {
    setLoading(true);
    var response = await getActiveTicketsDataSource.getActiveTickets(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    //print(response);
    getActiveTicketsResponse = GetActiveTicketsResponse.fromJson(response);
    if(getActiveTicketsResponse.code == "100"){
      getAllTickets = getActiveTicketsResponse.ticket!;
    }
    setLoading(false);

    return getActiveTicketsResponse;
  }

  GetQrTextEnResponse getQrTextEnResponse = GetQrTextEnResponse();
  GetQRTextEnDataSource getQRTextEnDataSource = GetQRTextEnDataSource();
  String qrTextEncrypt = "";



  Future<GetQrTextEnResponse> getQrTextEn(String ticketNo) async {
    var response = await getQRTextEnDataSource.getQRTextEnApi(ticketNo, AppConstants.MY_TOKEN);
    //print(response);
    getQrTextEnResponse = GetQrTextEnResponse.fromJson(response);
    if(getQrTextEnResponse.code=="100"){
      qrTextEncrypt = getQrTextEnResponse.text.toString();
    }
    // setLoading(false);

    return getQrTextEnResponse;

  }


  PassengerConfirmDetailsResponse passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse();
  PassengerConfirmDetailsDataSource passengerConfirmDetailsDataSource = PassengerConfirmDetailsDataSource();
  Future<PassengerConfirmDetailsResponse> getPassengerConfirmationDetails(String ticketNumber) async {
    var response = await passengerConfirmDetailsDataSource.passengerConfirmDetailsApi(ticketNumber,AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse.fromJson(response);

    return passengerConfirmDetailsResponse;
  }


  concatSeatsNumber() {

    String totalSeatsCount ="";
    for(int i=0;i<passengerConfirmDetailsResponse.ticketDeatil!.length;i++){
      totalSeatsCount = totalSeatsCount+"," + passengerConfirmDetailsResponse.ticketDeatil![i].seatno.toString();
    }

    return totalSeatsCount.substring(1);

  }
  bool _isLoading = true;
  get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }



  AuthenticationMethodDataSource authenticationMethodDataSource = AuthenticationMethodDataSource();
  AuthenticationMethodResponse authenticationMethodResponse = AuthenticationMethodResponse();
  Future<AuthenticationMethodResponse> authenticationMethod() async {
    var response = await authenticationMethodDataSource.authenticationMethod(AppConstants.AUTH_USER_ID, AppConstants.AUTH_IMEI);
    //print(response);
    authenticationMethodResponse = AuthenticationMethodResponse.fromJson(response);
    if(authenticationMethodResponse.code=="100"){
      AppConstants.MY_TOKEN = authenticationMethodResponse.result![0].token.toString();
    }
    return authenticationMethodResponse;
  }

}