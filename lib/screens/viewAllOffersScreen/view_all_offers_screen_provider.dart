import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/offersDataSource/offers_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/offers_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class ViewAllOffersProvider extends ChangeNotifier{


  OffersResponse offersResponse = OffersResponse();
  List<Offers> offersList = [];
  OffersSource offersSource = OffersSource();
  Future<OffersResponse> getAllOffers() async{
    var response = await offersSource.offersApi(AppConstants.USER_MOBILE_NO,AppConstants.MY_TOKEN);
    //print(response);
    offersResponse = OffersResponse.fromJson(response);
    if(offersResponse.code=="100"){
      offersList = offersResponse.offers!;
    }else{
      offersList = [];
    }

    setloading(false);

    return offersResponse;

  }

  // Future<GetStationsResponse> fetchPosts(dynamic response) async {
  //   return (response).map((p) => GetStationsResponse.fromJson(p));
  // }


  bool _isloading = true;

  get isloading => _isloading;

  setloading(bool boolvalue){
    _isloading = boolvalue;
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