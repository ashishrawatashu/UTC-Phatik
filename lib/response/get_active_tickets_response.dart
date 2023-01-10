class GetActiveTicketsResponse {
  GetActiveTicketsResponse({
      this.code, 
      this.ticket, 
      this.msg,});

  GetActiveTicketsResponse.fromJson(dynamic json) {
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
      this.bookingdatetime, 
      this.servicetypenameen, 
      this.deptitme, 
      this.arrival, 
      this.amountcommission, 
      this.amountconcession, 
      this.amountfare, 
      this.amountoffer, 
      this.amountonlreservation, 
      this.amounttax, 
      this.amounttotal, 
      this.source, 
      this.destination, 
      this.boarding, 
      this.totalseatsbooked, 
      this.currentstatuscode, 
      this.paymentmode, 
      this.journeystatus, 
      this.busno, 
      this.conductorcode, 
      this.conductorname, 
      this.conductormobile, 
      this.drivercode, 
      this.drivername, 
      this.drivermobile,});

  Ticket.fromJson(dynamic json) {
    ticketno = json['TICKET_NO'];
    journeydate = json['JOURNEY_DATE'];
    bookingdatetime = json['BOOKING_DATETIME'];
    servicetypenameen = json['SERVICE_TYPE_NAME_EN'];
    deptitme = json['DEPTITME'];
    arrival = json['ARRIVAL'];
    amountcommission = json['AMOUNT_COMMISSION'];
    amountconcession = json['AMOUNT_CONCESSION'];
    amountfare = json['AMOUNT_FARE'];
    amountoffer = json['AMOUNT_OFFER'];
    amountonlreservation = json['AMOUNT_ONL_RESERVATION'];
    amounttax = json['AMOUNT_TAX'];
    amounttotal = json['AMOUNT_TOTAL'];
    source = json['SOURCE'];
    destination = json['DESTINATION'];
    boarding = json['BOARDING'];
    totalseatsbooked = json['TOTAL_SEATS_BOOKED'];
    currentstatuscode = json['CURRENT_STATUS_CODE'];
    paymentmode = json['PAYMENT_MODE'];
    journeystatus = json['JOURNEYSTATUS'];
    busno = json['BUSNO'];
    conductorcode = json['CONDUCTORCODE'];
    conductorname = json['CONDUCTORNAME'];
    conductormobile = json['CONDUCTORMOBILE'];
    drivercode = json['DRIVERCODE'];
    drivername = json['DRIVERNAME'];
    drivermobile = json['DRIVERMOBILE'];
  }
  String? ticketno;
  String? journeydate;
  String? bookingdatetime;
  String? servicetypenameen;
  String? deptitme;
  String? arrival;
  int? amountcommission;
  int? amountconcession;
  int? amountfare;
  int? amountoffer;
  int? amountonlreservation;
  int? amounttax;
  int? amounttotal;
  String? source;
  String? destination;
  String? boarding;
  int? totalseatsbooked;
  String? currentstatuscode;
  String? paymentmode;
  String? journeystatus;
  String? busno;
  String? conductorcode;
  String? conductorname;
  String? conductormobile;
  String? drivercode;
  String? drivername;
  String? drivermobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TICKET_NO'] = ticketno;
    map['JOURNEY_DATE'] = journeydate;
    map['BOOKING_DATETIME'] = bookingdatetime;
    map['SERVICE_TYPE_NAME_EN'] = servicetypenameen;
    map['DEPTITME'] = deptitme;
    map['ARRIVAL'] = arrival;
    map['AMOUNT_COMMISSION'] = amountcommission;
    map['AMOUNT_CONCESSION'] = amountconcession;
    map['AMOUNT_FARE'] = amountfare;
    map['AMOUNT_OFFER'] = amountoffer;
    map['AMOUNT_ONL_RESERVATION'] = amountonlreservation;
    map['AMOUNT_TAX'] = amounttax;
    map['AMOUNT_TOTAL'] = amounttotal;
    map['SOURCE'] = source;
    map['DESTINATION'] = destination;
    map['BOARDING'] = boarding;
    map['TOTAL_SEATS_BOOKED'] = totalseatsbooked;
    map['CURRENT_STATUS_CODE'] = currentstatuscode;
    map['PAYMENT_MODE'] = paymentmode;
    map['JOURNEYSTATUS'] = journeystatus;
    map['BUSNO'] = busno;
    map['CONDUCTORCODE'] = conductorcode;
    map['CONDUCTORNAME'] = conductorname;
    map['CONDUCTORMOBILE'] = conductormobile;
    map['DRIVERCODE'] = drivercode;
    map['DRIVERNAME'] = drivername;
    map['DRIVERMOBILE'] = drivermobile;
    return map;
  }

}