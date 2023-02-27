import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/applyOfferDataSource/apply_offer_data_source.dart';
import 'package:utc_flutter_app/dataSource/getPaymentsGatewaysDataSource/get_payments_gateways_data_source.dart';
import 'package:utc_flutter_app/dataSource/getWalletDetails/get_wallet_data_source.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_data_source.dart';
import 'package:utc_flutter_app/dataSource/removeOfferDataSource/remove_offer_data_source.dart';
import 'package:utc_flutter_app/dataSource/ticketUpdateDataSource/ticket_update_data_source.dart';
import 'package:utc_flutter_app/dataSource/walletTicketConfirmDataSource/wallet_ticket_confirm_data_source.dart';
import 'package:utc_flutter_app/response/apply_remove_offer_response.dart';
import 'package:utc_flutter_app/response/get_payment_gateways_response.dart';
import 'package:utc_flutter_app/response/get_wallet_response.dart';
import 'package:utc_flutter_app/response/passenger_confirm_details_response.dart';
import 'package:utc_flutter_app/response/ticket_update_response.dart';
import 'package:utc_flutter_app/response/wallet_ticket_confirm_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';

class PaymentScreenProvider extends ChangeNotifier{

  String ticketNumber = "";
  num amountBalance = 0;
  double totalAmount = 0;
  int totalDiscount = 0;
  bool viewOffers = true;
  String couponCode = "";
  String couponId = "";
  bool isOfferApplied = false;
  bool isValidCode = true;


  //confirmDetails
  List<TicketDeatil> ticketDeatils = [];
  List<TicketFare> ticketFare = [];
  List<TicketTax> taxes = [];

  PassengerConfirmDetailsResponse passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse();
  PassengerConfirmDetailsDataSource passengerConfirmDetailsDataSource = PassengerConfirmDetailsDataSource();
  Future<PassengerConfirmDetailsResponse> getPassengerConfirmationDetails(String ticketNumber) async {
    var response = await passengerConfirmDetailsDataSource.passengerConfirmDetailsApi(ticketNumber,AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse.fromJson(response);
    if(passengerConfirmDetailsResponse.code=="100"){
      ticketDeatils = passengerConfirmDetailsResponse.ticketDeatil!;
      ticketFare = passengerConfirmDetailsResponse.ticketFare!;
      taxes = passengerConfirmDetailsResponse.ticketTax!;
      totalAmount = passengerConfirmDetailsResponse.ticketFare![0].netfare!.toDouble();
    }

    return passengerConfirmDetailsResponse;
  }

//updateTickets
  TicketUpdateResponse ticketUpdateResponse = TicketUpdateResponse();
  TicketUpdateDataSource ticketUpdateDataSource = TicketUpdateDataSource();
  Future<TicketUpdateResponse> updateTicket() async {
    var response = await ticketUpdateDataSource.getTicketUpdateApi(ticketNumber, "W");
    //print(response);
    setLoading(false);
    ticketUpdateResponse = TicketUpdateResponse.fromJson(response);
    if(ticketUpdateResponse.code=="100"){

    }

    return ticketUpdateResponse;
  }


  //wallet_ticket_confirm

  //updateTickets
  WalletTicketConfirmResponse walletTicketConfirmResponse = WalletTicketConfirmResponse();
  WalletTicketConfirmDataSource walletTicketConfirmDataSource = WalletTicketConfirmDataSource();
  Future<WalletTicketConfirmResponse>  walletTicketConfirm() async {
    var response = await walletTicketConfirmDataSource.walletTicketConfirmApi(AppConstants.USER_MOBILE_NO, ticketNumber, AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    walletTicketConfirmResponse = WalletTicketConfirmResponse.fromJson(response);

    return walletTicketConfirmResponse;
  }


//wallet details
  GetWalletDataSource getWalletDataSource = GetWalletDataSource();
  GetWalletResponse getWalletResponse = GetWalletResponse();
  Future<GetWalletResponse> getWalletDetails(String userId) async{
    setLoading(true);
    var response = await getWalletDataSource.getWalletApi(userId,AppConstants.MY_TOKEN);

    //print(response);
    getWalletResponse = GetWalletResponse.fromJson(response);
    if(!getWalletResponse.wallet!.isEmpty) {
      amountBalance = getWalletResponse.wallet![0].currentbalanceamount!;

      notifyListeners();

    }


    setLoading(false);
    return getWalletResponse;

  }


  ApplyRemoveOfferResponse applyRemoveOfferResponse = ApplyRemoveOfferResponse();
  //apply offers
  ApplyOfferDataSource applyOfferDataSource = ApplyOfferDataSource();
  Future<ApplyRemoveOfferResponse> applyOffer(String ticketNo, String offerId) async{
    // setLoading(true);
    var response = await applyOfferDataSource.applyOffer(AppConstants.USER_MOBILE_NO,ticketNo,offerId,AppConstants.MY_TOKEN);
    //print(response);
    applyRemoveOfferResponse = ApplyRemoveOfferResponse.fromJson(response);
    if(applyRemoveOfferResponse.code=="100"){
      if(applyRemoveOfferResponse.offers![0].status=="DONE"||applyRemoveOfferResponse.offers![0].status=="ALREADYUSED"){
        isOfferApplied = true;
        isValidCode = true;
        totalDiscount = applyRemoveOfferResponse.offers![0].offeramount!;
        totalAmount = applyRemoveOfferResponse.offers![0].totalamount!.toDouble();
        couponCode = applyRemoveOfferResponse.offers![0].couponcode!;
      }else if(applyRemoveOfferResponse.offers![0].status=="INVALIDCOUPON") {
        isOfferApplied = false;
        isValidCode = false;
      }
      notifyListeners();
    }

    // setLoading(false);
    return applyRemoveOfferResponse;

  }

//remove offers
  RemoveOfferDataSource removeOfferDataSource = RemoveOfferDataSource();
  Future<ApplyRemoveOfferResponse> removeOffer(String ticketNo, String couponCode) async{
    var response = await removeOfferDataSource.removeOffer(AppConstants.USER_MOBILE_NO,ticketNo,couponCode,AppConstants.MY_TOKEN);

    //print(response);
    applyRemoveOfferResponse = ApplyRemoveOfferResponse.fromJson(response);
    if(applyRemoveOfferResponse.code=="100"){
      isOfferApplied = false;
      if(applyRemoveOfferResponse.offers![0].status=="DONE"){
        totalDiscount = applyRemoveOfferResponse.offers![0].offeramount!;
        totalAmount = applyRemoveOfferResponse.offers![0].totalamount!.toDouble();
      }

      // couponCode = applyRemoveOfferResponse.offers![0].couponcode!;
      notifyListeners();
    }
    return applyRemoveOfferResponse;

  }


  //load payment Gateways
  List<Pg> paymentGatewaysList = [];
  GetPaymentGatewaysResponse getPaymentGatewaysResponse = GetPaymentGatewaysResponse();
  GetPaymentGatewaysDataSource getPaymentGatewaysDataSource = GetPaymentGatewaysDataSource();
  Future<GetPaymentGatewaysResponse> getPaymentGateways() async{
    setLoading(true);
    var response = await getPaymentGatewaysDataSource.getPaymentGatewaysApi(AppConstants.USER_MOBILE_NO, AppConstants.MY_TOKEN);
    //print(response);
    getPaymentGatewaysResponse = GetPaymentGatewaysResponse.fromJson(response);

    if(getPaymentGatewaysResponse.code=="100") {
      paymentGatewaysList = getPaymentGatewaysResponse.pg!;
      notifyListeners();
    }


    setLoading(false);
    return getPaymentGatewaysResponse;

  }


  bool _isLoading = true;
  get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }


  checkWalletBalance(){
    //print(amountBalance);
    //print(totalAmount);
    if(amountBalance<=totalAmount){
      return false;
    }else{
      return true;
    }

  }



}