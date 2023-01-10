
abstract class SearchBusesApi{
  Future<dynamic> getSearchBusesApi(String fromStationName, String toStationName, String serviceTypeId, String date, String token);
}