import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:utc_flutter_app/response/passenger_information_pojo.dart';

class AppConstants {

  static String username ="";
  static String password ="";
  static String auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));


  static int index = 0;
  static int ADVANCE_DAYS_BOOKING = 0;
  static String TOKEN = "8A5CE72749C4FEAAB9D5D1EBD34735D0FD32442F";
  static String IS_APP_ACTIVE_TOKEN = "C7B21607E40B96E142889B56354089DA92A12A34";
  static String AUTH_USER_ID = "8A5CE72749C4FEAAB9D5D1EBD34735D0FD32442F";
  static String AUTH_IMEI = "8A5CE72749C4FEAAB9D5D1EBD34735D0FD32442F";
  static String HELP_DESK_PHONE = "";
  static String HELP_DESK_EMAIL = "";

  // static String app_base_url_pg_or_img = "https://utcdemo.uk.gov.in/utcaudit";
  static String app_base_url_pg_or_img = "https://utconline.uk.gov.in";
  // static String app_base_url = "https://utcdemo.uk.gov.in/utcaudit";
  static String app_base_url = "https://utconline.uk.gov.in";
  static String PAYMENT_GATEWAY_URL ="$app_base_url_pg_or_img/pg/pgRedirection.aspx?token=";
  static String OFFER_IMAGE_URL ="$app_base_url_pg_or_img/DBimg/offers/";
  static String PG_IMAGE_URL ="$app_base_url_pg_or_img/DBimg/PG/";
  static String bus_type_url ="$app_base_url_pg_or_img/dbimg/BusServices/";
  static String AMINITIES_URL ="$app_base_url_pg_or_img/dbimg/amenity/";

  static String TERSM_AND_CONDITIONS= "$app_base_url/termAndConditions.htm";
  static String DOWNLOAD_TICKET_URL = "$app_base_url/pathikWebPage/tkt.aspx";
  static String CANCELLATION_POLICY= "$app_base_url/cancellationpolicy.htm";
  static String DISCLAIMER= "$app_base_url/disclaimer.htm";
  static String PRIVACY_POLICY= "$app_base_url/privacyPolicy.htm";
  static String TRACK_MY_BUS= "$app_base_url/pathikWebPage/trackMyBus.aspx";
  static String MEAL_ON_WHEEL_URL ="$app_base_url/pathikWebPage/mealonwheel.aspx";
  static String REFUND_STATUS_URL ="$app_base_url/pathikWebPage/refundStatus.aspx";
//72F1310103202319
   //FF23022402009

  // static String TERSM_AND_CONDITIONS= "http://utcdemo.uk.gov.in/utcauditpathik/termAndConditions.htm";
  // static String DOWNLOAD_TICKET_URL = "https://utcdemo.uk.gov.in/utcauditpathik/webpages/tkt.aspx";
  //
  // static String CANCELLATION_POLICY= "http://utcdemo.uk.gov.in/utcauditpathik/cancellationpolicy.htm";
  // static String DISCLAIMER= "http://utcdemo.uk.gov.in/utcauditpathik/disclaimer.htm";
  // static String PRIVACY_POLICY= "http://utcdemo.uk.gov.in/utcauditpathik/privacyPolicy.htm";


  static String WALLET_BOOKING_DESE = "You can pay ticket amount using your wallet it is fast, Secure and easy way to make your booking complete. ";
  static String? DEVICE_ID = "";
  static final DateFormat formatter = DateFormat('dd/MM/yyy');
  static String USER_MOBILE_NO = "";
  static String USER_NAME = "";
  static String SELECTED_SOURCE = "";
  static String SOURCE_CITY = "";
  static String SOURCE_CITY_ID = "";
  static String SELECTED_DESTINATION = "";
  static String SELECTED_DESTINATION_ID = "";
  static String DESTINITION_CITY = "";
  static String JOURNEY_DATE = "";
  static String JOURNEY_TIME = "";
  static String SERVICE_TYPE_ID = "0";
  static String SERICE_TYPE_NAME = "";
  static String SERICE_TYPE_ID = "";
  static String LAT = "";
  static String LONGG = "";
  static String MY_TOKEN = "";
  static int MAX_SEAT_SELECT = 0;
  static bool HIT_FIRST_TIME = false;
  static bool OFFERS = true;
  static bool NOTIFICATIONS = false;
   static List<PassengerInformationPojo> passengerList11 = [];
  // static List<Offers> offers = [];

  static final DateFormat formatter2 = DateFormat('yyyy-MM-dd hh:mm:ss');
  late int month ; late int year ;late int date ;
  getMonth(){
    for(int i=0;i>JOURNEY_DATE.length;i++){

    }
  }


  // static String OFFER_IMAGE_URL ="http://utcdemo.uk.gov.in/utcaudit/DBimg/offers/";
  // static String PG_IMAGE_URL ="http://utcdemo.uk.gov.in/utcaudit/DBimg/PG/";


}
