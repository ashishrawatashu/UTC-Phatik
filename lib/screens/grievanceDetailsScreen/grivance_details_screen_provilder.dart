import 'package:flutter/material.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/grivanceDetailsDataSource/gerivance_details_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_grievance_details_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class GrievanceDetailsScreenProvider extends ChangeNotifier {
  GetGrivanceDetailsDataSource getGrivanceDetailsDataSource = GetGrivanceDetailsDataSource();
  GetGrievanceDetailsResponse getGrievanceDetailsResponse = GetGrievanceDetailsResponse();
  Future<GetGrievanceDetailsResponse> getGrivanceDetails(String refNo) async{
    setLoading(true);
    var response = await getGrivanceDetailsDataSource.getGrievanceDetailsApi(AppConstants.USER_MOBILE_NO,refNo,AppConstants.MY_TOKEN);
    //print(response);
    getGrievanceDetailsResponse = GetGrievanceDetailsResponse.fromJson(response);
    setLoading(false);
    return getGrievanceDetailsResponse;

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