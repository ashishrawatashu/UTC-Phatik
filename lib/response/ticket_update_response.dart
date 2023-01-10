class TicketUpdateResponse {
  TicketUpdateResponse({
      this.code, 
      this.result, 
      this.msg,});

  TicketUpdateResponse.fromJson(dynamic json) {
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
      this.pRslt,});

  Result.fromJson(dynamic json) {
    pRslt = json['p_rslt'];
  }
  String? pRslt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p_rslt'] = pRslt;
    return map;
  }

}