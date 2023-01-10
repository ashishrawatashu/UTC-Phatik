class NotificationResponse {
  NotificationResponse({
      this.code, 
      this.tittle, 
      this.text, 
      this.msg,});

  NotificationResponse.fromJson(dynamic json) {
    code = json['code'];
    tittle = json['Tittle'];
    text = json['Text'];
    msg = json['msg'];
  }
  String? code;
  String? tittle;
  String? text;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['Tittle'] = tittle;
    map['Text'] = text;
    map['msg'] = msg;
    return map;
  }

}