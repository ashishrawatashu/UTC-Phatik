class PassengerConfirmDetailsResponse {
  PassengerConfirmDetailsResponse({
      this.code, 
      this.ticketDeatil, 
      this.ticketFare, 
      this.ticketTax, 
      this.ticketLog, 
      this.msg,});

  PassengerConfirmDetailsResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['ticketDeatil'] != null) {
      ticketDeatil = [];
      json['ticketDeatil'].forEach((v) {
        ticketDeatil?.add(TicketDeatil.fromJson(v));
      });
    }
    if (json['ticketFare'] != null) {
      ticketFare = [];
      json['ticketFare'].forEach((v) {
        ticketFare?.add(TicketFare.fromJson(v));
      });
    }
    if (json['ticketTax'] != null) {
      ticketTax = [];
      json['ticketTax'].forEach((v) {
        ticketTax?.add(TicketTax.fromJson(v));
      });
    }
    if (json['ticketLog'] != null) {
      ticketLog = [];
      json['ticketLog'].forEach((v) {
        ticketLog?.add(TicketLog.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<TicketDeatil>? ticketDeatil;
  List<TicketFare>? ticketFare;
  List<TicketTax>? ticketTax;
  List<TicketLog>? ticketLog;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (ticketDeatil != null) {
      map['ticketDeatil'] = ticketDeatil?.map((v) => v.toJson()).toList();
    }
    if (ticketFare != null) {
      map['ticketFare'] = ticketFare?.map((v) => v.toJson()).toList();
    }
    if (ticketTax != null) {
      map['ticketTax'] = ticketTax?.map((v) => v.toJson()).toList();
    }
    if (ticketLog != null) {
      map['ticketLog'] = ticketLog?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class TicketLog {
  TicketLog({
      this.ticketnumber, 
      this.logstatus, 
      this.logstatusdesc, 
      this.updationdatetime,});

  TicketLog.fromJson(dynamic json) {
    ticketnumber = json['TICKETNUMBER'];
    logstatus = json['LOGSTATUS'];
    logstatusdesc = json['LOGSTATUSDESC'];
    updationdatetime = json['UPDATIONDATETIME'];
  }
  String? ticketnumber;
  String? logstatus;
  String? logstatusdesc;
  String? updationdatetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNUMBER'] = ticketnumber;
    map['LOGSTATUS'] = logstatus;
    map['LOGSTATUSDESC'] = logstatusdesc;
    map['UPDATIONDATETIME'] = updationdatetime;
    return map;
  }

}

class TicketTax {
  TicketTax({
      this.tax, 
      this.amount,});

  TicketTax.fromJson(dynamic json) {
    tax = json['TAX'];
    amount = json['AMOUNT'];
  }
  String? tax;
  int? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TAX'] = tax;
    map['AMOUNT'] = amount;
    return map;
  }

}

class TicketFare {
  TicketFare({
      this.totalfareamt, 
      this.busrescharges, 
      this.totconsessionamt, 
      this.netfare, 
      this.totaltax, 
      this.ctzmobileno, 
      this.bookedbyuserid,});

  TicketFare.fromJson(dynamic json) {
    totalfareamt = json['TOTALFAREAMT'];
    busrescharges = json['BUSRESCHARGES'];
    totconsessionamt = json['TOTCONSESSIONAMT'];
    netfare = json['NETFARE'];
    totaltax = json['TOTALTAX'];
    ctzmobileno = json['CTZMOBILENO'];
    bookedbyuserid = json['BOOKEDBYUSERID'];
  }
  dynamic? totalfareamt;
  dynamic? busrescharges;
  dynamic? totconsessionamt;
  dynamic? netfare;
  dynamic? totaltax;
  String? ctzmobileno;
  String? bookedbyuserid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TOTALFAREAMT'] = totalfareamt;
    map['BUSRESCHARGES'] = busrescharges;
    map['TOTCONSESSIONAMT'] = totconsessionamt;
    map['NETFARE'] = netfare;
    map['TOTALTAX'] = totaltax;
    map['CTZMOBILENO'] = ctzmobileno;
    map['BOOKEDBYUSERID'] = bookedbyuserid;
    return map;
  }

}

class TicketDeatil {
  TicketDeatil({
      this.ticketno, 
      this.seatno, 
      this.passengername, 
      this.gender, 
      this.age, 
      this.ticketbookingstatus, 
      this.pmtgatewayid, 
      this.banktransactionno, 
      this.status, 
      this.bookingdatetime, 
      this.source, 
      this.destination, 
      this.boarding, 
      this.journeydate, 
      this.departuretimea, 
      this.totalseats, 
      this.berr, 
      this.perr, 
      this.herr, 
      this.servicetypenameen, 
      this.servicecode, 
      this.servicetripcode, 
      this.tripdirection,});

  TicketDeatil.fromJson(dynamic json) {
    ticketno = json['TICKETNO'];
    seatno = json['SEATNO'];
    passengername = json['PASSENGERNAME'];
    gender = json['GENDER'];
    age = json['AGE'];
    ticketbookingstatus = json['TICKETBOOKINGSTATUS'];
    pmtgatewayid = json['PMTGATEWAYID'];
    banktransactionno = json['BANKTRANSACTIONNO'];
    status = json['STATUS'];
    bookingdatetime = json['BOOKINGDATETIME'];
    source = json['SOURCE'];
    destination = json['DESTINATION'];
    boarding = json['BOARDING'];
    journeydate = json['JOURNEYDATE'];
    departuretimea = json['DEPARTURETIMEA'];
    totalseats = json['TOTALSEATS'];
    berr = json['BERR'];
    perr = json['PERR'];
    herr = json['HERR'];
    servicetypenameen = json['SERVICE_TYPE_NAME_EN'];
    servicecode = json['SERVICECODE'];
    servicetripcode = json['SERVICETRIPCODE'];
    tripdirection = json['TRIP_DIRECTION'];
  }
  String? ticketno;
  int? seatno;
  String? passengername;
  String? gender;
  int? age;
  String? ticketbookingstatus;
  int? pmtgatewayid;
  dynamic banktransactionno;
  String? status;
  String? bookingdatetime;
  String? source;
  String? destination;
  String? boarding;
  String? journeydate;
  String? departuretimea;
  int? totalseats;
  String? berr;
  String? perr;
  String? herr;
  String? servicetypenameen;
  int? servicecode;
  int? servicetripcode;
  String? tripdirection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKETNO'] = ticketno;
    map['SEATNO'] = seatno;
    map['PASSENGERNAME'] = passengername;
    map['GENDER'] = gender;
    map['AGE'] = age;
    map['TICKETBOOKINGSTATUS'] = ticketbookingstatus;
    map['PMTGATEWAYID'] = pmtgatewayid;
    map['BANKTRANSACTIONNO'] = banktransactionno;
    map['STATUS'] = status;
    map['BOOKINGDATETIME'] = bookingdatetime;
    map['SOURCE'] = source;
    map['DESTINATION'] = destination;
    map['BOARDING'] = boarding;
    map['JOURNEYDATE'] = journeydate;
    map['DEPARTURETIMEA'] = departuretimea;
    map['TOTALSEATS'] = totalseats;
    map['BERR'] = berr;
    map['PERR'] = perr;
    map['HERR'] = herr;
    map['SERVICE_TYPE_NAME_EN'] = servicetypenameen;
    map['SERVICECODE'] = servicecode;
    map['SERVICETRIPCODE'] = servicetripcode;
    map['TRIP_DIRECTION'] = tripdirection;
    return map;
  }

}