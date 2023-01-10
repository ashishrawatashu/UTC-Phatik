class TicketsResponse {
  TicketsResponse({
      this.code, 
      this.ticket, 
      this.msg,});

  TicketsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Ticket'] != null) {
      ticket = [];
      json['Ticket'].forEach((v) {
        ticket?.add(TicketsDetails.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<TicketsDetails>? ticket;
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

class TicketsDetails {
  TicketsDetails({
      this.ticketno, 
      this.journeydate, 
      this.tripcode, 
      this.bookingdatetime, 
      this.ticketbookingstatus, 
      this.isprint, 
      this.servicecode, 
      this.busservicetypename, 
      this.deptitme, 
      this.arrival, 
      this.actualdeparturetime, 
      this.actualarivaltime, 
      this.emailid, 
      this.tripstatus, 
      this.bkdatetime,
    this.source,
    this.destination,
    this.boarding,});

  TicketsDetails.fromJson(dynamic json) {
    ticketno = json['TICKETNO'];
    journeydate = json['JOURNEYDATE'];
    tripcode = json['TRIPCODE'];
    bookingdatetime = json['BOOKINGDATETIME'];
    ticketbookingstatus = json['TICKETBOOKINGSTATUS'];
    isprint = json['ISPRINT'];
    servicecode = json['SERVICECODE'];
    busservicetypename = json['BUSSERVICETYPENAME'];
    deptitme = json['DEPTITME'];
    arrival = json['ARRIVAL'];
    actualdeparturetime = json['ACTUALDEPARTURETIME'];
    actualarivaltime = json['ACTUALARIVALTIME'];
    emailid = json['EMAILID'];
    tripstatus = json['TRIPSTATUS'];
    bkdatetime = json['BKDATETIME'];
    source = json['SOURCE'];
    destination = json['DESTINATION'];
    boarding = json['BOARDING'];
  }
  String? ticketno;
  String? journeydate;
  String? tripcode;
  String? bookingdatetime;
  String? ticketbookingstatus;
  int? isprint;
  int? servicecode;
  String? busservicetypename;
  String? deptitme;
  String? arrival;
  String? actualdeparturetime;
  dynamic actualarivaltime;
  dynamic emailid;
  String? tripstatus;
  String? bkdatetime;
  String? source;
  String? destination;
  String? boarding;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNO'] = ticketno;
    map['JOURNEYDATE'] = journeydate;
    map['TRIPCODE'] = tripcode;
    map['BOOKINGDATETIME'] = bookingdatetime;
    map['TICKETBOOKINGSTATUS'] = ticketbookingstatus;
    map['ISPRINT'] = isprint;
    map['SERVICECODE'] = servicecode;
    map['BUSSERVICETYPENAME'] = busservicetypename;
    map['DEPTITME'] = deptitme;
    map['ARRIVAL'] = arrival;
    map['ACTUALDEPARTURETIME'] = actualdeparturetime;
    map['ACTUALARIVALTIME'] = actualarivaltime;
    map['EMAILID'] = emailid;
    map['TRIPSTATUS'] = tripstatus;
    map['BKDATETIME'] = bkdatetime;
    map['SOURCE'] = emailid;
    map['DESTINATION'] = tripstatus;
    map['BOARDING'] = bkdatetime;
    return map;
  }

}