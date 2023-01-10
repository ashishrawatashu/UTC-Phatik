class GetLastTicketLogResponse {
  GetLastTicketLogResponse({
      String? code, 
      List<Result>? result, 
      String? msg,}){
    _code = code;
    _result = result;
    _msg = msg;
}

  GetLastTicketLogResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['Result'] != null) {
      _result = [];
      json['Result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<Result>? _result;
  String? _msg;
  GetLastTicketLogResponse copyWith({  String? code,
  List<Result>? result,
  String? msg,
}) => GetLastTicketLogResponse(  code: code ?? _code,
  result: result ?? _result,
  msg: msg ?? _msg,
);
  String? get code => _code;
  List<Result>? get result => _result;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_result != null) {
      map['Result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class Result {
  Result({
      int? ticketStatusId, 
      String? ticketStatusName, 
      String? currentStatusDatetime,}){
    _ticketStatusId = ticketStatusId;
    _ticketStatusName = ticketStatusName;
    _currentStatusDatetime = currentStatusDatetime;
}

  Result.fromJson(dynamic json) {
    _ticketStatusId = json['ticket_status_id'];
    _ticketStatusName = json['ticket_status_name'];
    _currentStatusDatetime = json['current_status_datetime'];
  }
  int? _ticketStatusId;
  String? _ticketStatusName;
  String? _currentStatusDatetime;
Result copyWith({  int? ticketStatusId,
  String? ticketStatusName,
  String? currentStatusDatetime,
}) => Result(  ticketStatusId: ticketStatusId ?? _ticketStatusId,
  ticketStatusName: ticketStatusName ?? _ticketStatusName,
  currentStatusDatetime: currentStatusDatetime ?? _currentStatusDatetime,
);
  int? get ticketStatusId => _ticketStatusId;
  String? get ticketStatusName => _ticketStatusName;
  String? get currentStatusDatetime => _currentStatusDatetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticket_status_id'] = _ticketStatusId;
    map['ticket_status_name'] = _ticketStatusName;
    map['current_status_datetime'] = _currentStatusDatetime;
    return map;
  }

}