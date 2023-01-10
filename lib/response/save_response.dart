class SaveResponse {
  SaveResponse({
      this.code, 
      this.ticket, 
      this.msg,});

  SaveResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Ticket'] != null) {
      ticket = [];
      json['Ticket'].forEach((v) {
        ticket?.add(Ticket.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Ticket>? ticket;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (ticket != null) {
      map['Ticket'] = ticket?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Ticket {
  Ticket({
      this.rslt,});

  Ticket.fromJson(dynamic json) {
    rslt = json['RSLT'];
  }
  String? rslt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RSLT'] = rslt;
    return map;
  }

}