import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utc_flutter_app/dataSource/authenticationMethodDataSource/authentication_method_data_source.dart';
import 'package:utc_flutter_app/dataSource/getCancelAvailableTicketsDataSource/getCancelAvailableTickets_data_source.dart';
import 'package:utc_flutter_app/dataSource/getQRTextEnDataSource/get_qr_text_en_data_source.dart';
import 'package:utc_flutter_app/dataSource/passengerConfirmDetails/passenger_confirm_details_data_source.dart';
import 'package:utc_flutter_app/dataSource/ticketUpdateDataSource/ticket_update_data_source.dart';
import 'package:utc_flutter_app/dataSource/ticketsBusDataSource/tickets_data_source.dart';
import 'package:utc_flutter_app/response/authentication_method_response.dart';
import 'package:utc_flutter_app/response/get_cancel_available_tickets_response.dart';
import 'package:utc_flutter_app/response/get_qr_text_en_response.dart';
import 'package:utc_flutter_app/response/passenger_confirm_details_response.dart';
import 'package:utc_flutter_app/response/ticket_update_response.dart';
import 'package:utc_flutter_app/response/tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/pdf_viewer_page.dart';

class MyTicketsProvider extends ChangeNotifier{



  bool all = true;
  bool confirmed = false;
  bool cancelled = false;
  bool failed = false;

  List<Ticket> ticketsList = [];
  List<TicketsDetails> ticketDetails = [];
  TicketsDataSource ticketsDataSource = TicketsDataSource();
  TicketsResponse ticketsResponse = TicketsResponse();

  Future<TicketsResponse> getTickets() async {
    setLoading(true);
    var response = await ticketsDataSource.getTicketsApi(AppConstants.USER_MOBILE_NO,"",AppConstants.MY_TOKEN);
    //print(response);
    ticketsResponse = TicketsResponse.fromJson(response);
    if(ticketsResponse.code=="100"){
      ticketDetails = ticketsResponse.ticket!;
    }
    setLoading(false);
    return ticketsResponse;
  }



  GetCancelAvailableTicketsResponse getCancelAvailableTicketsResponse = GetCancelAvailableTicketsResponse();
  GetCancelAvailableTicketsDataSource getCancelAvailableTicketsDataSource = GetCancelAvailableTicketsDataSource();



  Future<GetCancelAvailableTicketsResponse> getCancelAvailableTickets() async {
    setLoading(true);
    var response = await getCancelAvailableTicketsDataSource.getCancelAvailableTicketsApi(AppConstants.USER_MOBILE_NO, "", "T", AppConstants.MY_TOKEN);
    //print(response);
    getCancelAvailableTicketsResponse = GetCancelAvailableTicketsResponse.fromJson(response);
    if(getCancelAvailableTicketsResponse.code=="100"){
      ticketsList = getCancelAvailableTicketsResponse.ticket!;
    }
    setLoading(false);

    return getCancelAvailableTicketsResponse;

  }

  PassengerConfirmDetailsResponse passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse();
  PassengerConfirmDetailsDataSource passengerConfirmDetailsDataSource = PassengerConfirmDetailsDataSource();
  Future<PassengerConfirmDetailsResponse> getPassengerConfirmationDetails(String ticketNumber) async {
    var response = await passengerConfirmDetailsDataSource.passengerConfirmDetailsApi(ticketNumber,AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse.fromJson(response);

    return passengerConfirmDetailsResponse;
  }

  concatSeatsNumber() {

    String totalSeatsCount ="";
    for(int i=0;i<passengerConfirmDetailsResponse.ticketDeatil!.length;i++){
      totalSeatsCount = totalSeatsCount+"," + passengerConfirmDetailsResponse.ticketDeatil![i].seatno.toString();
    }

    return totalSeatsCount.substring(1);

  }

  checkStatus(int index){
    if(ticketDetails[index].ticketbookingstatus=="CONFIRMED"){
      return "Confirmed";
    }else if(ticketDetails[index].ticketbookingstatus=="CANCELLED"){
      return "Cancelled";
    }else if(ticketDetails[index].ticketbookingstatus=="FAILED"){
      return "Failed";
    }
  }

  setIconOnStatus(int index){

    if(ticketDetails[index].ticketbookingstatus=="CONFIRMED"){
      return "assets/images/confirm_status.png";
    }else if(ticketDetails[index].ticketbookingstatus=="CANCELLED"){
      return "assets/images/notconfirm_status.png";
    }else if(ticketDetails[index].ticketbookingstatus=="FAILED"){
      return "assets/images/notconfirm_status.png";
    }

  }

  checkStatusColor(int index){
    if(ticketDetails[index].ticketbookingstatus=="CONFIRMED"){
      return HexColor(MyColors.green);
    }else {
      return  HexColor(MyColors.redColor);
    }

  }


  GetQrTextEnResponse getQrTextEnResponse = GetQrTextEnResponse();
  GetQRTextEnDataSource getQRTextEnDataSource = GetQRTextEnDataSource();
  String qrTextEncrypt = "";



  Future<GetQrTextEnResponse> getQrTextEn(String ticketNo) async {
    // setLoading(true);
    var response = await getQRTextEnDataSource.getQRTextEnApi(ticketNo, AppConstants.MY_TOKEN);
    //print(response);
    getQrTextEnResponse = GetQrTextEnResponse.fromJson(response);
    if(getQrTextEnResponse.code=="100"){
      qrTextEncrypt = getQrTextEnResponse.text.toString();
    }
    // setLoading(false);

    return getQrTextEnResponse;

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

  allIsActive(){
    all = true;
    confirmed = false;
    cancelled = false;
    failed = false;
    notifyListeners();
  }

  confirmedActive(){
    all = false;
    confirmed = true;
    cancelled = false;
    failed = false;
    notifyListeners();
  }

  cancelledActive(){
    all = false;
    confirmed = false;
    cancelled = true;
    failed = false;
    notifyListeners();
  }

  failedActive(){
    all = false;
    confirmed = false;
    cancelled = false;
    failed = true;
    notifyListeners();
  }


  setAllColor(){
    if(all==true){
      return HexColor(MyColors.white);
    }else {
      return HexColor(MyColors.primaryColor);
    }
  }


  setFailedColor(){
    if(failed==true){
      return HexColor(MyColors.white);
    }else {
      return HexColor(MyColors.primaryColor);
    }
  }

  setConfirmedColor(){
    if(confirmed==true){
      return HexColor(MyColors.white);
    }else {
      return HexColor(MyColors.primaryColor);
    }
  }

  setCancelledColor(){
    if(cancelled==true){
      return HexColor(MyColors.white);
    }else {
      return HexColor(MyColors.primaryColor);
    }
  }

  setAllBgColor(){
    if(all==true){
      return HexColor(MyColors.primaryColor);
    }else {
      return HexColor(MyColors.white);
    }
  }

  setConfirmedBgColor(){
    if(confirmed==true){
      return HexColor(MyColors.primaryColor);
    }else {
      return HexColor(MyColors.white);
    }
  }


  setCancelledBgColor(){
    if(cancelled==true){
      return HexColor(MyColors.primaryColor);
    }else {
      return HexColor(MyColors.white);
    }
  }

  setFailedBgColor(){
    if(failed==true){
      return HexColor(MyColors.primaryColor);
    }else {
      return HexColor(MyColors.white);
    }
  }

  filterTicket(int index) {
    if(all==true){
      return true;
    }

    if(confirmed==true&&ticketDetails[index].ticketbookingstatus=="CONFIRMED"||cancelled==true&&ticketDetails[index].ticketbookingstatus=="CANCELLED"||failed==true&&ticketDetails[index].ticketbookingstatus=="FAILED"){
      return true;
    }else{
      return false;
    }


  }


  Future<File> storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      //print('$file');
    }
    return file;
  }

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );


  Future<bool> saveFile(String url, String fileName,BuildContext context) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/UTC Ticket";
        directory = Directory(newPath);
        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          //print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(url, saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

}