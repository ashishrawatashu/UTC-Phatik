class GetRatingTicketsResponse {
  GetRatingTicketsResponse({
      this.code, 
      this.ticket, 
      this.msg,});

  GetRatingTicketsResponse.fromJson(dynamic json) {
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
      this.journeydate, 
      this.fromstationcode, 
      this.tostationcode, 
      this.fromstation, 
      this.tostation, 
      this.servicecode, 
      this.busservicetypename, 
      this.departure, 
      this.arrival, 
      this.journeyduration,});

  Ticket.fromJson(dynamic json) {
    ticketno = json['TICKETNO'];
    journeydate = json['JOURNEYDATE'];
    fromstationcode = json['FROMSTATIONCODE'];
    tostationcode = json['TOSTATIONCODE'];
    fromstation = json['FROMSTATION'];
    tostation = json['TOSTATION'];
    servicecode = json['SERVICECODE'];
    busservicetypename = json['BUSSERVICETYPENAME'];
    departure = json['DEPARTURE'];
    arrival = json['ARRIVAL'];
    journeyduration = json['JOURNEYDURATION'];
  }
  String? ticketno;
  String? journeydate;
  int? fromstationcode;
  int? tostationcode;
  String? fromstation;
  String? tostation;
  int? servicecode;
  String? busservicetypename;
  String? departure;
  String? arrival;
  int? journeyduration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNO'] = ticketno;
    map['JOURNEYDATE'] = journeydate;
    map['FROMSTATIONCODE'] = fromstationcode;
    map['TOSTATIONCODE'] = tostationcode;
    map['FROMSTATION'] = fromstation;
    map['TOSTATION'] = tostation;
    map['SERVICECODE'] = servicecode;
    map['BUSSERVICETYPENAME'] = busservicetypename;
    map['DEPARTURE'] = departure;
    map['ARRIVAL'] = arrival;
    map['JOURNEYDURATION'] = journeyduration;
    return map;
  }

}