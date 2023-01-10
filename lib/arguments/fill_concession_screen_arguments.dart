import 'package:utc_flutter_app/response/passenger_information_pojo.dart';

class FillConcessionScreenArguments {
  String emailId;
  String depotServiceCode;
  String triptype;
  String tripid;
  String fromStationId;
  String toStationId;
  String bordeingStationId;
  final List<PassengerInformationPojo> passengerList;

  FillConcessionScreenArguments(
      this.emailId,
      this.depotServiceCode,
      this.triptype,
      this.tripid,
      this.fromStationId,
      this.toStationId,
      this.bordeingStationId,
      this.passengerList);
}