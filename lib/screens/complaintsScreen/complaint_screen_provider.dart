import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/complaintsDataSource/get_complaints_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_grievance_reponse.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class ComplaintsScreenProvider extends ChangeNotifier{


  List<Grievance> getGrivanceList = [];
  GetGrievanceReponse  getGrievanceReponse = GetGrievanceReponse();
  GetGrievanceDataSource getGrievanceDataSource = GetGrievanceDataSource();
  Future<GetGrievanceReponse> getGrievance() async {
    setLoading(true);
    var response = await getGrievanceDataSource.getGrievanceApi(AppConstants.USER_MOBILE_NO,AppConstants.MY_TOKEN);
    getGrievanceReponse= GetGrievanceReponse.fromJson(response);
    if(getGrievanceReponse.code=="100"){
      getGrivanceList = getGrievanceReponse.grievance!;
    }
    //print(response);
    setLoading(false);
    return getGrievanceReponse;
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