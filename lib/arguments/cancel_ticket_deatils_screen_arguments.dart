
class CancelTicketsScreenDetailsArguments {

  final String ticketNo;
  final String source;
  final String destination;
  final String boardingStation;
  final String journeyDate;
  final String serviceTypeName;
  final String departureTime;
  final String arrivalTime;

  CancelTicketsScreenDetailsArguments(
      this.ticketNo,
      this.source,
      this.destination,
      this.boardingStation,
      this.journeyDate,
      this.serviceTypeName,
      this.departureTime,
      this.arrivalTime);
}