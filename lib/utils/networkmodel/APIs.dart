import 'package:flutter/cupertino.dart';
class APIs {
  APIs._();

  // Base url
  // static const String baseUrl = "https://utcdemo.uk.gov.in/utcaudit/wstraveller.asmx";
  static const String baseUrl = "https://utconline.uk.gov.in/wstraveller.asmx";

  static const String AuthenticationMethod = "$baseUrl/AuthenticationMethod";

  //login and register API

  static const String trvl_checkMobileNo = "$baseUrl/trvl_checkMobileNo";
  static const String trvl_loginFail = "$baseUrl/trvl_loginFail";
  static const String trvl_loginFirstTime = "$baseUrl/trvl_loginFirstTime";
  static const String trvl_loginSuccess = "$baseUrl/trvl_loginSuccess";
  static const String isAppActive = "$baseUrl/isAppActive";

  //wallet API
  static const String getWallet = "$baseUrl/walletDetails";

  static const String bus_serviceType = "$baseUrl/bus_serviceType";

  //wallet_Details_Transactions
  static const String wallet_Details_Transactions = "$baseUrl/wallet_Details_Transactions";

  //dashboard API
  static const String trvl_Dashboard = "$baseUrl/trvl_Dashboard";


  // search buses APis
  static const String search_station_app = "$baseUrl/search_station_app";
  static const String search_services = "$baseUrl/search_services";

  // layout_boarding
  static const String layout_boarding = "$baseUrl/layout_boarding";

  // savePassengers
  static const String savePassengers = "$baseUrl/savePassengers";

  // passengerConfirmDetails
  static const String passengerConfirmDetails = "$baseUrl/passengerConfirmDetails";

  //tickets
  static const String tickets = "$baseUrl/tickets";

  //getTickets
  static const String getTickets = "$baseUrl/getTickets";

  //getTicketDetails
  static const String getTicketDetails = "$baseUrl/getTicketDetails";

  //ticket Update
  static const String ticketUpdate = "$baseUrl/ticketUpdate";

  //saveCancelTicket
  static const String saveCancelTicket = "$baseUrl/saveCancelTicket";

  //getCancelAvailableTickets
  static const String getCancelAvailableTickets = "$baseUrl/getCancelAvailableTickets";

  //getCancelAvailableTicketsPsngr
  static const String getCancelAvailableTicketsPsngr = "$baseUrl/getCancelAvailableTicketsPsngr";

  //getGrievanc
  static const String getGrievance = "$baseUrl/getGrievances";

  //getGrievanceCategorie
  static const String getGrievanceCategories = "$baseUrl/getGrievanceCategories";

  //getGrievanceDetail
  static const String getGrievanceDetail = "$baseUrl/getGrievanceDetail";

  //saveGrievance
  static const String saveGrievance = "$baseUrl/saveGrievance";

  //walletTopupStartCompleted
  static const String walletTopupStartCompleted = "$baseUrl/walletTopupStartCompleted";

  //walletTopupTxnStatus
  static const String walletTopupTxnStatus = "$baseUrl/walletTopupTxnStatus";

  //getRatingTickets
  static const String getRatingTickets = "$baseUrl/getRatingTickets";

  //saveRating
  static const String saveRating = "$baseUrl/saveRating";

  //offers
  static const String offers = "$baseUrl/offers";

  //applyOffer
  static const String applyOffer = "$baseUrl/offerApply";

  //removeOffer
  static const String removeOffer = "$baseUrl/offerRemove";

  //walletTopupStartCompleted

  static const String walletTopup = "$baseUrl/walletTopupStartCompleted";

  //walletTopupTxnStatus

  static const String walletTopupStatus = "$baseUrl/walletTopupTxnStatus";

  //wallet_Ticket_Confirm

  static const String wallet_Ticket_Confirm = "$baseUrl/wallet_Ticket_Confirm";

  //getLastTicketLog

  static const String getLastTicketLog = "$baseUrl/getLastTicketLog";

  //getPaymentGateways

  static const String getPaymentGateways = "$baseUrl/getPaymentGateways";

  //getPaymentGateways

  static const String getAlarmCategories = "$baseUrl/getAlarmCategories";

  //saveAlarm

  static const String saveAlarm = "$baseUrl/saveAlarm";

  //getActiveTickets

  static const String getActiveTickets = "$baseUrl/getActiveTickets";

  //getConfirmTickets

  static const String getConfirmTickets = "$baseUrl/getConfirmTickets";

  //getQRTextEn
  static const String getQRTextEn = "$baseUrl/getQRTextEn";

  //notifService
  static const String notifService = "$baseUrl/notifService";

  //notifOffer
  static const String notifOffer = "$baseUrl/notifOffer";

  //getRefundTickets
  static const String getRefundTickets = "$baseUrl/getRefundTickets";

  //getConcessionTypes
  static const String getConcessionTypes = "$baseUrl/getConcessionTypes";

  //checkConcession
  static const String checkConcession = "$baseUrl/checkConcession";

  //checkConcessionPass
  static const String checkConcessionPass = "$baseUrl/checkConcessionPass";

  //offerDetails
  static const String offerDetails = "$baseUrl/offerDetails";

  //removeToken
  static const String removeToken = "$baseUrl/removeToken";

  static const String send_ticket_confirmation = "$baseUrl/send_ticket_confirmation";

  static late BuildContext context;

}
