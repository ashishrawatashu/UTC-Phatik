class SeatLayoutBoardingArguments {
  final String serviceTypeID;
  final String dsvcId;
  final String strpId;
  final String tripType;
  final String toStationId;
  final String fromStationId;
  final List<String> amenitiesUrlList;

  SeatLayoutBoardingArguments(this.dsvcId,this.strpId,this.tripType, this.toStationId, this.fromStationId,this.amenitiesUrlList, this.serviceTypeID);

}