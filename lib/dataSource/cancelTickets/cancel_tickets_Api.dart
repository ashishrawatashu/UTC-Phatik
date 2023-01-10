abstract class CancelTicketsApi {
  Future<dynamic> cancelTickets(String userId, String ticketNo, String seatNos, String seatCounts, String cancellededByType, String token);
}
