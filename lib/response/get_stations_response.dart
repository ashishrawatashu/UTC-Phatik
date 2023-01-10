class GetStationsResponse {
  GetStationsResponse({
      this.code, 
      this.station, 
      this.msg,});

  GetStationsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Station'] != null) {
      station = [];
      json['Station'].forEach((v) {
        station?.add(Station.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Station>? station;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (station != null) {
      map['Station'] = station?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Station {
  Station({
      this.stonid, 
      this.stonname,});

  Station.fromJson(dynamic json) {
    stonid = json['STATIONCODE'];
    stonname = json['STATIONNAME'];
  }
  int? stonid;
  String? stonname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATIONCODE'] = stonid;
    map['STATIONNAME'] = stonname;
    return map;
  }

}