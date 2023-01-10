class GetCancelAvailableTicketsResponse {
  GetCancelAvailableTicketsResponse({
      String? code, 
      List<Ticket>? ticket, 
      String? msg,}){
    _code = code;
    _ticket = ticket;
    _msg = msg;
}

  GetCancelAvailableTicketsResponse.fromJson(dynamic json) {
    _code = json['code'];
    if (json['Ticket'] != null) {
      _ticket = [];
      json['Ticket'].forEach((v) {
        _ticket?.add(Ticket.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<Ticket>? _ticket;
  String? _msg;

  String? get code => _code;
  List<Ticket>? get ticket => _ticket;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_ticket != null) {
      map['Ticket'] = _ticket?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

class Ticket {
  Ticket({
      String? ticketno, 
      String? journeydate, 
      String? departuretime, 
      String? arrivaltime, 
      String? source, 
      String? destination, 
      String? bookingdatetime, 
      String? tripdate, 
      int? servicecode, 
      String? busservicetypename,}){
    _ticketno = ticketno;
    _journeydate = journeydate;
    _departuretime = departuretime;
    _arrivaltime = arrivaltime;
    _source = source;
    _destination = destination;
    _bookingdatetime = bookingdatetime;
    _tripdate = tripdate;
    _servicecode = servicecode;
    _busservicetypename = busservicetypename;
}

  Ticket.fromJson(dynamic json) {
    _ticketno = json['TICKETNO'];
    _journeydate = json['JOURNEYDATE'];
    _departuretime = json['DEPARTURETIME'];
    _arrivaltime = json['ARRIVALTIME'];
    _source = json['SOURCE'];
    _destination = json['DESTINATION'];
    _bookingdatetime = json['BOOKINGDATETIME'];
    _tripdate = json['TRIPDATE'];
    _servicecode = json['SERVICECODE'];
    _busservicetypename = json['BUSSERVICETYPENAME'];
  }
  String? _ticketno;
  String? _journeydate;
  String? _departuretime;
  String? _arrivaltime;
  String? _source;
  String? _destination;
  String? _bookingdatetime;
  String? _tripdate;
  int? _servicecode;
  String? _busservicetypename;

  String? get ticketno => _ticketno;
  String? get journeydate => _journeydate;
  String? get departuretime => _departuretime;
  String? get arrivaltime => _arrivaltime;
  String? get source => _source;
  String? get destination => _destination;
  String? get bookingdatetime => _bookingdatetime;
  String? get tripdate => _tripdate;
  int? get servicecode => _servicecode;
  String? get busservicetypename => _busservicetypename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNO'] = _ticketno;
    map['JOURNEYDATE'] = _journeydate;
    map['DEPARTURETIME'] = _departuretime;
    map['ARRIVALTIME'] = _arrivaltime;
    map['SOURCE'] = _source;
    map['DESTINATION'] = _destination;
    map['BOOKINGDATETIME'] = _bookingdatetime;
    map['TRIPDATE'] = _tripdate;
    map['SERVICECODE'] = _servicecode;
    map['BUSSERVICETYPENAME'] = _busservicetypename;
    return map;
  }

}