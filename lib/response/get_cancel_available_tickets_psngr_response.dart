class GetCancelAvailableTicketsPsngrResponse {
  GetCancelAvailableTicketsPsngrResponse({
      this.code,
      this.ticket,
      this.msg,});

  GetCancelAvailableTicketsPsngrResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Ticket'] != null) {
      ticket = [];
      json['Ticket'].forEach((v) {
        ticket?.add(TicketDetails.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<TicketDetails>? ticket;
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

class TicketDetails {
  TicketDetails({
      this.seatno,
      this.nameofpasseneger,
      this.gender,
      this.age,
      this.category,
      this.fare,
      this.reservationCharges,
      this.selected,});

  TicketDetails.fromJson(dynamic json) {
    seatno = json['SEAT NO'];
    nameofpasseneger = json['NAME OF PASSENEGER'];
    gender = json['GENDER'];
    age = json['AGE'];
    category = json['CATEGORY'];
    fare = json['Fare'];
    reservationCharges = json['Reservation Charges'];
    refundAmount = json['REFUNDAMT'];
    selected = json['selected'];
  }
  int? seatno;
  String? nameofpasseneger;
  String? gender;
  int? age;
  String? category;
  int? fare;
  int? reservationCharges;
  dynamic? refundAmount;
  bool? selected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SEAT NO'] = seatno;
    map['NAME OF PASSENEGER'] = nameofpasseneger;
    map['GENDER'] = gender;
    map['AGE'] = age;
    map['CATEGORY'] = category;
    map['Fare'] = fare;
    map['Reservation Charges'] = reservationCharges;
    map['REFUNDAMT'] = refundAmount;
    map['selected'] = selected;
    return map;
  }
}