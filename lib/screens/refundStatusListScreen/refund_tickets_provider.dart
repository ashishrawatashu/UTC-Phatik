import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/refundTicketsDataSource/refund_tickets_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/refund_tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class RefundTicketsProvider extends ChangeNotifier {

  RefundTicketsResponse refundTicketsResponse = RefundTicketsResponse();
  RefundTicketsDataSource refundTicketsDataSource = RefundTicketsDataSource();
  List<Ticket> refundTicketsList = [];
  Future<RefundTicketsResponse> getRefundTickets() async {
    var response = await refundTicketsDataSource.refundTicketsApi(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    refundTicketsResponse = RefundTicketsResponse.fromJson(response);
    if(refundTicketsResponse.code=="100"){
      refundTicketsList = refundTicketsResponse.ticket!;
    }
    return refundTicketsResponse;
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