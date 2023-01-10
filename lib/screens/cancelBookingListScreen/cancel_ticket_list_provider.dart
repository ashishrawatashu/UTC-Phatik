import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_cancel_available_tickets_response.dart';

import '../../dataSource/getCancelAvailableTicketsDataSource/getCancelAvailableTickets_data_source.dart';
import '../../utils/app_constants.dart';

class CancelTicketListProvider extends ChangeNotifier{



  GetCancelAvailableTicketsResponse getCancelAvailableTicketsResponse = GetCancelAvailableTicketsResponse();
  GetCancelAvailableTicketsDataSource getCancelAvailableTicketsDataSource = GetCancelAvailableTicketsDataSource();
  List<Ticket> ticketsList = [];


  Future<GetCancelAvailableTicketsResponse> getCancelAvailableTickets() async {
    setLoading(true);
    var response = await getCancelAvailableTicketsDataSource.getCancelAvailableTicketsApi(AppConstants.USER_MOBILE_NO, "", "T", AppConstants.MY_TOKEN);
    //print(response);
    getCancelAvailableTicketsResponse = GetCancelAvailableTicketsResponse.fromJson(response);
    if(getCancelAvailableTicketsResponse.code=="100"){
      ticketsList = getCancelAvailableTicketsResponse.ticket!;
    }
    setLoading(false);

    return getCancelAvailableTicketsResponse;

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
    setLoading(true);
    var response = await authenticationMethodDataSource.authenticationMethod(AppConstants.AUTH_USER_ID, AppConstants.AUTH_IMEI);
    //print(response);
    authenticationMethodResponse = AuthenticationMethodResponse.fromJson(response);
    if(authenticationMethodResponse.code=="100"){
      AppConstants.MY_TOKEN = authenticationMethodResponse.result![0].token.toString();
    }

    setLoading(false);
    return authenticationMethodResponse;
  }


}