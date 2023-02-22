import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:utc_flutter_app/arguments/payment_screen_arguments.dart';
import 'package:utc_flutter_app/dataSource/getLastTicketLogDataSource/get_Last_Ticket_Log_data_source.dart';
import 'package:utc_flutter_app/dataSource/walletStatusDataSource/wallet_status_data_source.dart';
import 'package:utc_flutter_app/response/get_last_ticket_log_respone.dart';
import 'package:utc_flutter_app/response/wallet_top_up_response.dart';
import 'package:utc_flutter_app/response/wallet_top_up_status_response.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/screens/paymentWebViewScreen/show_dialog.dart';
import 'package:utc_flutter_app/utils/app_constants.dart';
import 'package:utc_flutter_app/utils/common_methods.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';

import '../../dataSource/passengerConfirmDetails/passenger_confirm_details_data_source.dart';
import '../../response/passenger_confirm_details_response.dart';

class PaymentWebViewScreenProvider extends ChangeNotifier {
  String wallettTxnRefrence = "";
  String ticketNumber = "";
  String from = "";
  String paymentGatewayName = "";
  String walletTopUpCompleted = "";
  String ticketStatus = "";
  WalletTopUpStatusDataSource walletTopUpStatusDataSource =
      WalletTopUpStatusDataSource();
  WalletTopUpStatusResponse walletTopUpStatusResponse =
      WalletTopUpStatusResponse();

  Future<WalletTopUpStatusResponse> walletTopUpStatus() async {
    var response = await walletTopUpStatusDataSource.walletTopUpStatusApi(
        wallettTxnRefrence, AppConstants.USER_MOBILE_NO);

    //print(response);
    walletTopUpStatusResponse = WalletTopUpStatusResponse.fromJson(response);

    if (walletTopUpStatusResponse.code == "100") {
      walletTopUpCompleted =
          walletTopUpStatusResponse.walletStatus![0].completeyn!;
    } else {
      walletTopUpCompleted = "N";
    }
    return walletTopUpStatusResponse;
  }

  GetLastTicketLogDataSource getLastTicketLogDataSource =
      GetLastTicketLogDataSource();
  GetLastTicketLogResponse getLastTicketLogResponse =
      GetLastTicketLogResponse();

  Future<GetLastTicketLogResponse> getLastTicketLog() async {
    var response = await getLastTicketLogDataSource.getLastTicketLogApi(
        AppConstants.USER_MOBILE_NO, ticketNumber);
    //print(response);
    getLastTicketLogResponse = GetLastTicketLogResponse.fromJson(response);

    if (getLastTicketLogResponse.code == "100") {
      ticketStatus = getLastTicketLogResponse.result![0].ticketStatusName!;
    } else {
      walletTopUpCompleted = "N";
    }
    return getLastTicketLogResponse;
  }

  PassengerConfirmDetailsResponse passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse();
  PassengerConfirmDetailsDataSource passengerConfirmDetailsDataSource = PassengerConfirmDetailsDataSource();

  Future<PassengerConfirmDetailsResponse> getPassengerConfirmationDetails() async {
    var response = await passengerConfirmDetailsDataSource.passengerConfirmDetailsApi(ticketNumber, AppConstants.MY_TOKEN);
    //print(response);
    passengerConfirmDetailsResponse = PassengerConfirmDetailsResponse.fromJson(response);
    return passengerConfirmDetailsResponse;
  }

  checkPaymentStatus(BuildContext context) async {
    CommonMethods.showLoadingDialog(context);
    //print(from);
    if (from == "Wallet") {
      Navigator.pop(context);
      AppConstants.index = 2;
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: DashboardScreen(),
        ),
      );
      if (walletTopUpCompleted == "Y") {
        CommonMethods.dialogDone(context, "Wallet recharged successfully ");
      } else {
        // CommonMethods.showSnackBar(context, "Something went wrong !");
      }
    } else if (from == "PaymentScreen") {
      await getPassengerConfirmationDetails();
      Navigator.pop(context);
      if (passengerConfirmDetailsResponse.code == "100") {
        if(!passengerConfirmDetailsResponse.ticketDeatil!.isEmpty){
          if (passengerConfirmDetailsResponse.ticketDeatil![0].ticketbookingstatus == "A") {
            CommonMethods.dialogDone(context, "Ticket booked successfully");
            Navigator.pushNamed(context, MyRoutes.bookingHistoryDetailsScreen, arguments: PaymentScreenArguments(ticketNumber, "Booking"));
          }else if (passengerConfirmDetailsResponse.ticketDeatil![0].ticketbookingstatus == "R") {
            paymentIsUnderProcessDialogBox(context,ticketNumber);
          }else if (passengerConfirmDetailsResponse.ticketDeatil![0].ticketbookingstatus == "F") {
            CommonMethods.showErrorMoveToDashBaordDialog(context, "Your booking is failed !");
          }
        }else {
          CommonMethods.showErrorMoveToDashBaordDialog(context, "Something went wrong, please try again ");
        }
      } else {
        CommonMethods.showSnackBar(context, "Ticket is not booked !");
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: DashboardScreen(),
          ),
        );
      }
    }
  }
}
