import 'package:flutter/cupertino.dart';
import 'package:utc_flutter_app/dataSource/cancelTickets/cancel_tickets_data_source.dart';
import 'package:utc_flutter_app/response/cancel_tickets_response.dart';
import 'package:utc_flutter_app/response/get_cancel_available_tickets_psngr_response.dart';
import 'package:utc_flutter_app/response/get_cancel_available_tickets_response.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import '../../dataSource/getCancelAvailableTicketsPsngrDataSource/get_cancel_available_tickets_psngr_data_source.dart';

class CancelTicketsProvider extends ChangeNotifier {
  String ticketNo = "";
  String source = "";
  String destination = "";
  String boardingStation = "";
  String journeyDate = "";
  String serviceTypeName = "";
  String departureTime = "";
  String arrivalTime = "";
  List<TicketDetails> ticketDetails = [];

  GetCancelAvailableTicketsPsngrResponse
      getCancelAvailableTicketsPsngrResponse =
      GetCancelAvailableTicketsPsngrResponse();
  GetCancelAvailableTicketsPsngrDataSource
      getCancelAvailableTicketsPsngrDataSource =
      GetCancelAvailableTicketsPsngrDataSource();

  Future<GetCancelAvailableTicketsPsngrResponse> getPassengerConfirmationDetails(String ticketNumber, BuildContext context) async {
    var response = await getCancelAvailableTicketsPsngrDataSource.getCancelAvailableTicketsPsngrApi(AppConstants.USER_MOBILE_NO, ticketNumber, "t", AppConstants.MY_TOKEN);
    // print(response);
    setLoading(false);
    getCancelAvailableTicketsPsngrResponse = GetCancelAvailableTicketsPsngrResponse.fromJson(response);
    if (getCancelAvailableTicketsPsngrResponse.code == "100") {
      ticketDetails = getCancelAvailableTicketsPsngrResponse.ticket!;
      selectedSeats = "";
      changeButtonColor();
    }else if (getCancelAvailableTicketsPsngrResponse.code == "999") {
      CommonMethods.showTokenExpireDialog(context);
    }else{
      Navigator.pop(context);
    }

    return getCancelAvailableTicketsPsngrResponse;
  }

  CancelTicketsResponse cancelTicketsResponse = CancelTicketsResponse();
  CancelTicketDataSource cancelTicketDataSource = CancelTicketDataSource();

  Future<CancelTicketsResponse> cancelTickets() async {
    // var response = await cancelTicketDataSource.cancelTickets(ticketNumber, selectedSeats, selectedSeatsAmount, selectedSeatsCount.toString(), AppConstants.USER_MOBILE_NO, AppConstants.DEVICE_ID!);
    var response = await cancelTicketDataSource.cancelTickets(
        AppConstants.USER_MOBILE_NO,
        ticketNo,
        selectedSeats,
        selectedSeatsCount.toString(),
        "T",
        AppConstants.MY_TOKEN);
    //print(response);
    setLoading(false);
    cancelTicketsResponse = CancelTicketsResponse.fromJson(response);

    return cancelTicketsResponse;
  }

  bool _isLoading = true;

  get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  selectSeat(int index, bool value) {
    if (ticketDetails[index].selected == null) {
      ticketDetails[index].selected = true;
    } else if (ticketDetails[index].selected == false) {
      ticketDetails[index].selected = true;
    } else {
      ticketDetails[index].selected = false;
    }
    concatSeatNoAndSeatAmount();
    notifyListeners();
  }

  setValueInCheckBox(int index) {
    if (ticketDetails[index].selected == null) {
      return false;
    } else if (ticketDetails[index].selected == false) {
      return false;
    } else if (ticketDetails[index].selected == true) {
      return true;
    }
  }

  String selectedSeats = "";
  String selectedSeatsAmount = "";
  int selectedSeatsCount = 0;

  concatSeatNoAndSeatAmount() {
    String seatNo = "";
    String seatAmount = "";
    selectedSeatsCount = 0;
    for (int i = 0; i < ticketDetails.length; i++) {
      if (ticketDetails[i].selected == true) {
        seatNo = seatNo + "," + ticketDetails[i].seatno.toString();
        seatAmount = seatAmount + "," + ticketDetails[i].fare.toString();
        selectedSeatsCount = selectedSeatsCount + 1;
      }
    }
    if (seatNo.length > 1) {
      selectedSeats = seatNo.substring(1);
      selectedSeatsAmount = seatAmount.substring(1);
    } else {
      selectedSeats = seatNo;
      selectedSeatsAmount = seatAmount;
    }
    //print(selectedSeats + "====>" + selectedSeatsAmount);
    changeButtonColor();
  }

  bool _isSelected = false;

  get isSelected => _isSelected;

  changeButtonColor() {
    //print(selectedSeats);
    if (selectedSeats == "") {
      _isSelected = false;
    } else {
      _isSelected = true;
    }

    notifyListeners();
  }

  setCancelButton(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
