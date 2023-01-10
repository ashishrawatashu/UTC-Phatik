class SavePassengersResponse {
  SavePassengersResponse({
      this.code, 
      this.result, 
      this.msg,});

  SavePassengersResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
      json['Result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Result>? result;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (result != null) {
      map['Result'] = result?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Result {
  Result({
      this.pTicketnumber,});

  Result.fromJson(dynamic json) {
    pTicketnumber = json['TICKETNUMBER'];
    fare = json['FARE'];
  }
  String? pTicketnumber;
  int? fare;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNUMBER'] = pTicketnumber;
    map['FARE'] = fare;
    return map;
  }

}