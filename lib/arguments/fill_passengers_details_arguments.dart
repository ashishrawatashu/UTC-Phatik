

import 'package:utc_flutter_app/response/passenger_information_pojo.dart';

class FillPassengersDetailsArguments {
  String depotServiceCode;
  String triptype;
  String tripid;
  String fromStationId;
  String toStationId;
  String bordeingStationId;
  List<PassengerInformationPojo> passengerInformationList;

  FillPassengersDetailsArguments(
      this.depotServiceCode,
      this.triptype,
      this.tripid,
      this.fromStationId,
      this.toStationId,
      this.bordeingStationId,
      this.passengerInformationList);

}