import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:utc_flutter_app/screens/activeBookingsScreen/active_booking_screen.dart';
import 'package:utc_flutter_app/screens/alertsScreens/alerts_screen.dart';
import 'package:utc_flutter_app/screens/appNotWorkingScreen/app_not_working_screen.dart';
import 'package:utc_flutter_app/screens/bookingHistoryDetailsScreen/booking_history_details_screen.dart';
import 'package:utc_flutter_app/screens/busSeatLayoutScreen/bus_seat_layout_screen.dart';
import 'package:utc_flutter_app/screens/busesListScreen/search_buses.dart';
import 'package:utc_flutter_app/screens/cancelBookingListScreen/cancel_booking_list_screen.dart';
import 'package:utc_flutter_app/screens/cancelTicketsScreen/cancel_tickets_screen.dart';
import 'package:utc_flutter_app/screens/comingSoonScreen/coming_soon_screen.dart';
import 'package:utc_flutter_app/screens/complaintsScreen/complaints_screen.dart';
import 'package:utc_flutter_app/screens/fillPassengerDeatailsScreen/fill_passengers_details_screen.dart';
import 'package:utc_flutter_app/screens/fillconcessionInfoScreen/fill_concession_screen.dart';
import 'package:utc_flutter_app/screens/getPhoneNumberScreen/get_phone_number_screen.dart';
import 'package:utc_flutter_app/screens/grievanceDetailsScreen/grievance_details_screen.dart';
import 'package:utc_flutter_app/screens/homeScreen/dashboard_screen.dart';
import 'package:utc_flutter_app/screens/introScreen/intro_screen.dart';
import 'package:utc_flutter_app/screens/locateMyBusScreen/locate_my_bus_screen.dart';
import 'package:utc_flutter_app/screens/myTransactionScreen/my_transation_screen.dart';
import 'package:utc_flutter_app/screens/offerDetailsScreen/offer_details_screen.dart';
import 'package:utc_flutter_app/screens/otpScreen/otp_screen.dart';
import 'package:utc_flutter_app/screens/paymentScreen/payment_screen.dart';
import 'package:utc_flutter_app/screens/paymentWebViewScreen/payment_web_view_screen.dart';
import 'package:utc_flutter_app/screens/raiseAlarmScreen/raise_alarm_screen.dart';
import 'package:utc_flutter_app/screens/ratingListScreen/rate_list_screen.dart';
import 'package:utc_flutter_app/screens/refundStatusListScreen/refund_status_list_screen.dart';
import 'package:utc_flutter_app/screens/registerComplaintScreen/complaint_screen.dart';
import 'package:utc_flutter_app/screens/registerScreen/register_screen.dart';
import 'package:utc_flutter_app/screens/selectPaymentOption/select_payment_option_screen.dart';
import 'package:utc_flutter_app/screens/splashScrenn/splash_screen.dart';
import 'package:utc_flutter_app/screens/trackMyBusScreen/track_my_bus_screen.dart';
import 'package:utc_flutter_app/screens/viewAllOffersScreen/view_all_offers_screen.dart';
import 'package:utc_flutter_app/screens/viewAllWalletHistoryScreen/view_all_wallet_history_screen.dart';
import 'package:utc_flutter_app/screens/webPagesScreen/webPagesScreen.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';
import 'package:utc_flutter_app/utils/my_routes.dart';
import 'demosScreens/PaymentConditionScreen.dart';
import 'demosScreens/condition_screens.dart';
import 'demosScreens/error_screen.dart';
import 'demosScreens/home_screen_condition.dart';
import 'di/providers.dart';
import 'screens/bottomTabsScreens/myBookingTab/my_history_tab.dart';
import 'screens/rateScreen/rate_screen.dart';
import 'screens/stationsScreen/stations_screen.dart';


class StarBusApp extends StatelessWidget {

  const StarBusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                maxWidth: 1400,
                minWidth: 360,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(360, name: MOBILE),
                  const ResponsiveBreakpoint.resize(600, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
              ),
            );
          },
        color: HexColor(MyColors.primaryColor),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColorDark: HexColor(MyColors.primaryColor),
              primaryColor: HexColor(MyColors.primaryColor),
              fontFamily: GoogleFonts.numans().fontFamily,
              primaryTextTheme: GoogleFonts.nunitoTextTheme()),
          // initialRoute: isSkipped=="true" ? MyRoutes.homeRoute : MyRoutes.introScreen,
          initialRoute: MyRoutes.splashScreen,
          routes: {
            MyRoutes.splashScreen: (context) => const SplashScreen(),
            MyRoutes.introScreen: (context) => const IntroScreen(),
            MyRoutes.getPhoneNumberScreen: (context) => GetPhoneNumberScreen(),
            MyRoutes.otpScreen: (context) => OtpScreen(),
            MyRoutes.registerScreen: (context) => const RegisterScreen(),
            MyRoutes.homeRoute: (context) => const DashboardScreen(),
            MyRoutes.searchBuses: (context) => const SearchBuses(),
            MyRoutes.selectPlace: (context) => const StationsScreen(),
            MyRoutes.viewAllOffers: (context) => ViewAllOffersScreen(),
            MyRoutes.offerDetailsScreen: (context) => OfferDetailsScreen(),
            MyRoutes.rateScreenList: (context) => RateListScreen(),
            MyRoutes.rateScreen: (context) => RateScreen(),
            MyRoutes.busSeatLayout: (context) => BusSeatLayoutScreen(),
            MyRoutes.fillPassengersDetails: (context) => FillPassengersDetailsScreen(),
            MyRoutes.paymentScreen: (context) => PaymentScreen(),
            MyRoutes.webPagesScreen: (context) => WebPagesScreen(),
            MyRoutes.selectPaymentOption: (context) => SelectPaymentOptionScreen(),
            MyRoutes.bookingHistoryDetailsScreen: (context) => BookingHistoryDetailsScreen(),
            MyRoutes.viewAllWalletHistoryScreen: (context) => ViewAllWalletHistoryScreen(),
            MyRoutes.cancelTicketsScreen: (context) => CancelTicketsScreen(),
            MyRoutes.registerComplaintScreen: (context) => RegisterComplaintScreen(),
            MyRoutes.complaintsScreen: (context) => ComplaintsScreen(),
            MyRoutes.grievanceDetailsScreen: (context) => GrievanceDetailsScreen(),
            MyRoutes.paymentWebViewScreen: (context) => PaymentWebViewScreen(),
            MyRoutes.locateMyBusScreen: (context) => LocateMyBusScreen(),
            MyRoutes.trackMyBusScreen: (context) => TrackMyBusScreen(),
            MyRoutes.raiseAlarmScreen: (context) => RaiseAlarmScreen(),
            MyRoutes.myTransactionScreen: (context) => MyTransactionScreen(),
            MyRoutes.refundStatusScreen: (context) => RefundStatusListScreen(),
            MyRoutes.activeBookingScreen: (context) => ActiveBookingScreen(),
            MyRoutes.appNotWorking: (context) => AppNotWorkingScreen(),
            // MyRoutes.allBookingHistoryScreen: (context) => AllBookingHistoryScreen(),
            MyRoutes.alertsSCreen: (context) => AlertsScreen(),
            MyRoutes.fillConcessionScreen: (context) => FillConcessionScreen(),
            MyRoutes.cancelTicketListScreen: (context) => CancelBookingListScreen(),
            MyRoutes.cancelTicketListScreen: (context) => CancelBookingListScreen(),
            //demo screens
            MyRoutes.paymentConditionsScreens: (context) => PaymentConditionsScreen(),
            MyRoutes.conditionScreen: (context) => ConditionsScreens(),
            MyRoutes.homeScreen2: (context) => HomeScreen2(),
            MyRoutes.errorMsg: (context) => ErrorScreen(),
            MyRoutes.mealOnWheel: (context) => MealOnWheelScreen(),

          }
      )
    );

  }
}