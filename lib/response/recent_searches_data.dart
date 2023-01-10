import 'dart:convert';

class RecentSearchesData {
  final String sourceId, destinationId, sourcecityname, destinationCityName, sourceStation,destinationStation,searchDate,sourceAndDestination;
  RecentSearchesData({
     required this.sourceId,
     required this.destinationId,
     required this.sourcecityname,
     required this.destinationCityName,
     required this.sourceStation,
     required this.destinationStation,
     required this.searchDate,
    required this.sourceAndDestination,
  });

  factory RecentSearchesData.fromJson(Map<String, dynamic> jsonData) {
    return RecentSearchesData(
      sourceId: jsonData['sourceId'],
      destinationId: jsonData['destinationId'],
      sourcecityname: jsonData['sourcecityname'],
      destinationCityName: jsonData['destinationCityName'],
      sourceStation: jsonData['sourceStation'],
      destinationStation: jsonData['destinationStation'],
      searchDate: jsonData['searchDate'],
      sourceAndDestination: jsonData['sourceAndDestination'],
    );
  }

  static Map<String, dynamic> toMap(RecentSearchesData recentSearchesData) => {
    'sourceId': recentSearchesData.sourceId,
    'destinationId': recentSearchesData.destinationId,
    'sourcecityname': recentSearchesData.sourcecityname,
    'destinationCityName': recentSearchesData.destinationCityName,
    'sourceStation': recentSearchesData.sourceStation,
    'destinationStation': recentSearchesData.destinationStation,
    'searchDate': recentSearchesData.searchDate,
    'sourceAndDestination':recentSearchesData.sourceAndDestination,
  };

  static String encode(List<RecentSearchesData> recentSearchesData) => json.encode(
    recentSearchesData
        .map<Map<String, dynamic>>((music) => RecentSearchesData.toMap(music))
        .toList(),
  );

  static List<RecentSearchesData> decode(String recentSearchesData) =>
      (json.decode(recentSearchesData) as List<dynamic>)
          .map<RecentSearchesData>((item) => RecentSearchesData.fromJson(item))
          .toList();

}