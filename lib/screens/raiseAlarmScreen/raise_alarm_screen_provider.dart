import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getAlarmCategoriesDataSource/get_alarm_categories_data_source.dart';
import 'package:utc_flutter_app/dataSource/saveAlarmDataSource/save_alarm_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_alarm_categories_response.dart';
import 'package:utc_flutter_app/response/save_alarm_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

import '../../dataSource/getActivTicketsDataSource/get_active_tickets_data_source.dart';
import '../../response/get_active_tickets_response.dart';
class RaiseAlarmScreenProvider extends ChangeNotifier{


  List<Alarm> alarmList = [];
  GetAlarmCategoriesResponse getAlarmCategoriesResponse = GetAlarmCategoriesResponse();
  GetAlarmCategoriesDataSource getAlarmCategoriesDataSource = GetAlarmCategoriesDataSource();

  Future<GetAlarmCategoriesResponse> getAlarmCategories() async{
    var response = await getAlarmCategoriesDataSource.getAlarmCategoriesApi(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    //print(response);
    getAlarmCategoriesResponse = GetAlarmCategoriesResponse.fromJson(response);
    if(getAlarmCategoriesResponse.code=="100"){
      alarmList = getAlarmCategoriesResponse.alarm!;
    }
    return getAlarmCategoriesResponse;

  }


  SaveAlarmResponse saveAlarmResponse  = SaveAlarmResponse();
  SaveAlarmDataSource saveAlarmDataSource = SaveAlarmDataSource();

  Future<GetAlarmCategoriesResponse> saveAlarm(String alarmTypeId,String ticketNo) async{
    var response = await saveAlarmDataSource.saveAlarmApi(alarmTypeId, AppConstants.USER_MOBILE_NO, AppConstants.LAT, AppConstants.LONGG ,ticketNo, AppConstants.MY_TOKEN);
    //print(response);
    saveAlarmResponse = SaveAlarmResponse.fromJson(response);
    return getAlarmCategoriesResponse;

  }

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