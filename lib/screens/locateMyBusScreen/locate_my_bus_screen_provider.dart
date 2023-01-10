import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getActivTicketsDataSource/get_active_tickets_data_source.dart';
import 'package:utc_flutter_app/dataSource/getConfirmTicketsDataSource/get_confirms_tickets_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_active_tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class LocateMyBusScreenBusProvider extends ChangeNotifier{


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
      // statusString = getActiveTicketsResponse.
    }
    setLoading(false);

    return getActiveTicketsResponse;
  }



  setTripStatusList(int index){
    String statusString = getAllTickets[index].journeystatus!;
    List<String> statusList = statusString.split(',');
    //print(statusList);
    return statusList;

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