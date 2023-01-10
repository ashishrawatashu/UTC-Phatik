import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getTicketsDataSource/get_rating_tickets_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_rating_tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class RatingListProvider extends ChangeNotifier{

  GetRatingTicketsResponse getRatingTicketsResponse = GetRatingTicketsResponse();
  GetRatingTicketsDataSource getRatingTicketsDataSource = GetRatingTicketsDataSource();
  List<Ticket> getRatingTicketsList = [];


  Future<GetRatingTicketsResponse> getRatingTickets() async {
    var response = await getRatingTicketsDataSource.getTicketsApi(AppConstants.USER_MOBILE_NO,AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    getRatingTicketsResponse = GetRatingTicketsResponse.fromJson(response);
    if(getRatingTicketsResponse.code=="100"){
      getRatingTicketsList = getRatingTicketsResponse.ticket!;
    }
    return getRatingTicketsResponse;
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