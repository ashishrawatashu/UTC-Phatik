import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utc_flutter_app/constants/strings.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getWalletDetails/get_wallet_data_source.dart';
import 'package:utc_flutter_app/dataSource/walletDetailsTransactionsDataSource/wallet_details_transactions_Api.dart';
import 'package:utc_flutter_app/dataSource/walletDetailsTransactionsDataSource/wallet_details_transactions_data_source.dart';
import 'package:utc_flutter_app/dataSource/walletTopUpDataSource/wallet_top_up_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_wallet_response.dart';
import 'package:utc_flutter_app/response/wallet_details_transactions_response.dart';
import 'package:utc_flutter_app/response/wallet_top_up_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

import '../../../dataSource/getPaymentsGatewaysDataSource/get_payments_gateways_data_source.dart';
import '../../../response/get_payment_gateways_response.dart';
class WalletTabProvider extends ChangeNotifier {


  bool _isValueEnter = false;
  get isValueEnter => _isValueEnter;
  String amountBalance ="0.00";
  TextEditingController enterAmountController = TextEditingController();
  String txnref = "";
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  String isUserLoggedIn = "";
  String isUserSkipped = "";



  void setValueInController(String value){
    enterAmountController.text = value.toString();
    enterAmountController.selection = TextSelection.fromPosition(TextPosition(offset: enterAmountController.text.length));
    var myAmount;
    if(value.length>1){
      myAmount = int.parse(value);
      assert(myAmount is int);
      if(myAmount>=100){
        _isValueEnter = true;
      }else{
        _isValueEnter = false;
      }
      notifyListeners();
    }

  }

  setAmountInWalletList(String txnType, String amount){
    if(txnType=="Booking"){
      return "-₹ "+amount;
    }else {
      return "+₹ "+amount;
    }

  }

  setAmountColorInWalletList(String txnType, String amount){
    if(txnType=="Booking"){
      return HexColor(MyColors.redColor);
    }else {
      return HexColor(MyColors.green);
    }
  }



  WalletTopUpDataSource walletTopUpDataSource = WalletTopUpDataSource();
  WalletTopUpResponse walletTopUpResponse = WalletTopUpResponse();
  Future<WalletTopUpResponse> topUpWallet() async{
    var response = await walletTopUpDataSource.walletTopUpeApi("0", AppConstants.USER_MOBILE_NO, enterAmountController.value.text.toString(), "L");

    //print(response);
    walletTopUpResponse = WalletTopUpResponse.fromJson(response);

    if(walletTopUpResponse.code=="100"){
      txnref = walletTopUpResponse.walletStatus![0].pRslt!;
      //print(txnref);
    }
    return walletTopUpResponse;

  }


  GetWalletDataSource getWalletDataSource = GetWalletDataSource();
  GetWalletResponse getWalletResponse = GetWalletResponse();
  Future<GetWalletResponse> getWalletDetails(String userId) async{
    setLoading(true);
    var response = await getWalletDataSource.getWalletApi(userId,"");

    //print(response);
    getWalletResponse = GetWalletResponse.fromJson(response);

    if(!getWalletResponse.wallet!.isEmpty){
      amountBalance = getWalletResponse.wallet![0].currentbalanceamount.toString();
    }


    setLoading(false);
    return getWalletResponse;

  }


  WalletDetailsTransactionsDataSource walletDetailsTransactionsDataSource = WalletDetailsTransactionsDataSource();
  WalletDetailsTransactionsResponse walletDetailsTransactionsResponse = WalletDetailsTransactionsResponse();
  Future<WalletDetailsTransactionsResponse> getWalletDetailsTransactions(String userId, BuildContext context) async{
    setLoading(true);
    var response = await walletDetailsTransactionsDataSource.walletDetailsTransactionsApi(userId, "1000", "L", AppConstants.MY_TOKEN);
    //print(response);
    walletDetailsTransactionsResponse = WalletDetailsTransactionsResponse.fromJson(response);

    if(walletDetailsTransactionsResponse.code=="100"){
      if(walletDetailsTransactionsResponse.wallet!.isEmpty){
        CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again");
      }else {
        amountBalance = walletDetailsTransactionsResponse.wallet![0].currentbalanceamount.toString();
      }
    }else if(walletDetailsTransactionsResponse.code=="101"){
      amountBalance = "0.0";
    }

    setLoading(false);
    return walletDetailsTransactionsResponse;

  }
  //load payment Gateways
  List<Pg> paymentGatewaysList = [];
  GetPaymentGatewaysResponse getPaymentGatewaysResponse = GetPaymentGatewaysResponse();
  GetPaymentGatewaysDataSource getPaymentGatewaysDataSource = GetPaymentGatewaysDataSource();
  Future<GetPaymentGatewaysResponse> getPaymentGateways(BuildContext context) async{
    // setLoading(true);
    var response = await getPaymentGatewaysDataSource.getPaymentGatewaysApi(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    //print(response);
    getPaymentGatewaysResponse = GetPaymentGatewaysResponse.fromJson(response);
    Navigator.pop(context);
    if(getPaymentGatewaysResponse.code=="100") {
      paymentGatewaysList = getPaymentGatewaysResponse.pg!;
      notifyListeners();
    }


    // setLoading(false);
    return getPaymentGatewaysResponse;

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


  getUserData(BuildContext context) async {
    await getIsLoggedIn();
    await getIsSkipped();
    if (isUserLoggedIn == "false" || isUserSkipped == "true") {
     CommonMethods.showErrorDialog(context, "Invalid User, Please login your account !");
    }

  }

  getIsLoggedIn() async {
    await encryptedSharedPreferences
        .getString(StringsFile.isLoggedIn)
        .then((String value) {
      isUserLoggedIn = value;

      /// Prints Hello, World!
    });
  }

  getIsSkipped() {
    encryptedSharedPreferences
        .getString(StringsFile.isSkipped)
        .then((String value) {
      isUserSkipped = value;

      /// Prints Hello, World!
    });
  }

}