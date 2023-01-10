class RefundTicketsResponse {
  RefundTicketsResponse({
      this.code, 
      this.ticket, 
      this.msg,});

  RefundTicketsResponse.fromJson(dynamic json) {
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
      this.ticketno, 
      this.cancellationrefno, 
      this.cancellationdate, 
      this.refundrefno, 
      this.refunddate, 
      this.refundamt,});

  Ticket.fromJson(dynamic json) {
    ticketno = json['TICKET_NO'];
    cancellationrefno = json['CANCELLATION_REF_NO'];
    cancellationdate = json['CANCELLATION_DATE'];
    refundrefno = json['REFUND_REF_NO'];
    refunddate = json['REFUND_DATE'];
    refundamt = json['REFUND_AMT'];
  }
  String? ticketno;
  String? cancellationrefno;
  String? cancellationdate;
  String? refundrefno;
  dynamic refunddate;
  dynamic refundamt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKET_NO'] = ticketno;
    map['CANCELLATION_REF_NO'] = cancellationrefno;
    map['CANCELLATION_DATE'] = cancellationdate;
    map['REFUND_REF_NO'] = refundrefno;
    map['REFUND_DATE'] = refunddate;
    map['REFUND_AMT'] = refundamt;
    return map;
  }

}