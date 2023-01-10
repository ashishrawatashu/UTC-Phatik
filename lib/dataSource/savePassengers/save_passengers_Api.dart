abstract class SavePassegersApi{
  Future<dynamic> savePassengersApi(
      String depotServiceCode,
      String tripType,
      String strpid,
      String journeyDate,
      String fromStationId,
      String toStationId,
      String bookingTypeCode,
      String userId,
      String userMobile,
      String userEmail,
      String bordeingStationId,
      String passengers,
      String ip_imei,
      String token);

}