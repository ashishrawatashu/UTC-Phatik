class SentTicketConfirmation {
  SentTicketConfirmation({
      this.code, 
      this.result, 
      this.msg,});

  SentTicketConfirmation.fromJson(dynamic json) {
    code = json['code'];
    if (json['Result'] != null) {
      result = [];
    }
    msg = json['msg'];
  }
  String? code;
  List<dynamic>? result;
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