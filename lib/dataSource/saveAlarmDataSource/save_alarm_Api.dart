abstract class SaveAlarmApi{
  Future<dynamic> saveAlarmApi(
      String alarmTypeId,
      String reportedBy,
      String latt,
      String longg,
      String ticketNo,
      String token);

}