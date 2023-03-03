import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/refundTicketsDataSource/refund_tickets_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/refund_tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';

import '../../arguments/web_page_url_arguments.dart';
import '../../utils/my_routes.dart';

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

  void checkRefundStatus(int index, BuildContext context) {
    if(refundTicketsList[index].refundrefno=="NA"){
      CommonMethods.showSnackBar(context, "Refund is under process ");
    }else {
      String refundStatusUrl = "";
      print(refundStatusUrl);

      final bytes = utf8.encode(refundTicketsList[index].ticketno!.toString());
      final base64TicketNumber = base64.encode(bytes);

      final bytesCN = utf8.encode(refundTicketsList[index].cancellationrefno!.toString());
      final base64CN = base64.encode(bytesCN);

      final bytesRN = utf8.encode(refundTicketsList[index].refundrefno!.toString());
      final base64RN = base64.encode(bytesRN);

      refundStatusUrl = AppConstants.REFUND_STATUS_URL+"?PN="+base64TicketNumber+"&CN="+base64CN+"&RN="+base64RN;
      print(refundStatusUrl);
      Navigator.pushNamed(context, MyRoutes.webPagesScreen,arguments: WebPageUrlArguments(refundStatusUrl, "Refund Status"));

    }
  }
}