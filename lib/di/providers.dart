import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:utc_flutter_app/screens/fillconcessionInfoScreen/fill_concession_info_screen_provider.dart';
import 'package:utc_flutter_app/screens/refundStatusListScreen/refund_tickets_provider.dart';
import 'package:utc_flutter_app/screens/stationsScreen/station_screen_provider.dart';

import '../common_provider_for_in_app_login.dart';
import '../screens/activeBookingsScreen/active_booking_screen_provider.dart';
import '../screens/bookingHistoryDetailsScreen/booking_history_detail_screen_provider.dart';
import '../screens/bottomTabsScreens/homeTab/home_tab_provider.dart';
import '../screens/bottomTabsScreens/myBookingTab/my_tickets_provider.dart';
import '../screens/bottomTabsScreens/walletTab/wallet_tab_provider.dart';
import '../screens/busSeatLayoutScreen/bus_seat_layout_screen_provider.dart';
import '../screens/busesListScreen/search_buses_provider.dart';
import '../screens/cancelBookingListScreen/cancel_ticket_list_provider.dart';
import '../screens/cancelTicketsScreen/cancel_tickets_provider.dart';
import '../screens/complaintsScreen/complaint_screen_provider.dart';
import '../screens/fillPassengerDeatailsScreen/fill_passengers_details_screen_provider.dart';
import '../screens/getPhoneNumberScreen/get_phone_number_provider.dart';
import '../screens/grievanceDetailsScreen/grivance_details_screen_provilder.dart';
import '../screens/homeScreen/dashboard_screen_provider.dart';
import '../screens/introScreen/intro_provider.dart';
import '../screens/locateMyBusScreen/locate_my_bus_screen_provider.dart';
import '../screens/otpScreen/otp_screen_provider.dart';
import '../screens/paymentScreen/payment_screen_provider.dart';
import '../screens/paymentWebViewScreen/payment_web_view_screen_provider.dart';
import '../screens/raiseAlarmScreen/raise_alarm_screen_provider.dart';
import '../screens/rateScreen/rate_screen_provider.dart';
import '../screens/ratingListScreen/rating_list_provider.dart';
import '../screens/registerComplaintScreen/complaint_screen_provider.dart';
import '../screens/splashScrenn/splash_screen_provider.dart';
import '../screens/trackMyBusScreen/track_my_bus_screen_provider.dart';
import '../screens/viewAllOffersScreen/view_all_offers_screen_provider.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider<SplashScreenProvider>(create:(context)=> SplashScreenProvider()),
  ChangeNotifierProvider<IntroScreenProvider>(create: (context) => IntroScreenProvider()),
  ChangeNotifierProvider<HomeTabProvider>(create: (context) => HomeTabProvider()),
  ChangeNotifierProvider<AllStationsProvider>(create:(context)=> AllStationsProvider()),
  ChangeNotifierProvider<SearchBusProvider>(create:(context)=> SearchBusProvider()),
  ChangeNotifierProvider<GetPhoneNumberProvider>(create:(context)=> GetPhoneNumberProvider()),
  ChangeNotifierProvider<OtpScreenProvider>(create:(context)=> OtpScreenProvider()),
  ChangeNotifierProvider<RateScreenProvider>(create:(context)=> RateScreenProvider()),
  ChangeNotifierProvider<RatingListProvider>(create:(context)=> RatingListProvider()),
  ChangeNotifierProvider<ViewAllOffersProvider>(create:(context)=> ViewAllOffersProvider()),
  ChangeNotifierProvider<BusSeatLayoutProvider>(create:(context)=> BusSeatLayoutProvider()),
  ChangeNotifierProvider<FillPassengersDetailsProvider>(create:(context)=> FillPassengersDetailsProvider()),
  ChangeNotifierProvider<WalletTabProvider>(create:(context)=> WalletTabProvider()),
  ChangeNotifierProvider<PaymentScreenProvider>(create:(context)=> PaymentScreenProvider()),
  ChangeNotifierProvider<MyTicketsProvider>(create:(context)=> MyTicketsProvider()),
  ChangeNotifierProvider<BookingHistoryDetailProvider>(create:(context)=> BookingHistoryDetailProvider()),
  ChangeNotifierProvider<CancelTicketsProvider>(create:(context)=> CancelTicketsProvider()),
  ChangeNotifierProvider<RegisterComplaintScreenProvider>(create:(context)=> RegisterComplaintScreenProvider()),
  ChangeNotifierProvider<ComplaintsScreenProvider>(create:(context)=> ComplaintsScreenProvider()),
  ChangeNotifierProvider<GrievanceDetailsScreenProvider>(create:(context)=> GrievanceDetailsScreenProvider()),
  ChangeNotifierProvider<PaymentWebViewScreenProvider>(create:(context)=> PaymentWebViewScreenProvider()),
  ChangeNotifierProvider<DashBoardScreenProvider>(create:(context)=> DashBoardScreenProvider()),
  ChangeNotifierProvider<CommonProviderForInAppLogin>(create:(context)=> CommonProviderForInAppLogin()),
  ChangeNotifierProvider<LocateMyBusScreenBusProvider>(create:(context)=> LocateMyBusScreenBusProvider()),
  ChangeNotifierProvider<TrackMyBusScreenProvider>(create:(context)=> TrackMyBusScreenProvider()),
  ChangeNotifierProvider<CancelTicketListProvider>(create:(context)=> CancelTicketListProvider()),
  ChangeNotifierProvider<RaiseAlarmScreenProvider>(create:(context)=> RaiseAlarmScreenProvider()),
  ChangeNotifierProvider<ActiveBookingScreenProvider>(create:(context)=> ActiveBookingScreenProvider()),
  ChangeNotifierProvider<RefundTicketsProvider>(create:(context)=> RefundTicketsProvider()),
  ChangeNotifierProvider<FillConcessionScreenProvider>(create:(context)=> FillConcessionScreenProvider()),
];
