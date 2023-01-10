class GetAlarmCategoriesResponse {
  GetAlarmCategoriesResponse({
      this.code, 
      this.alarm, 
      this.msg,});

  GetAlarmCategoriesResponse.fromJson(dynamic json) {
    code = json['code'];
    if (json['Alarm'] != null) {
      alarm = [];
      json['Alarm'].forEach((v) {
        alarm?.add(Alarm.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<Alarm>? alarm;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (alarm != null) {
      map['Alarm'] = alarm?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Alarm {
  Alarm({
      this.alarmtypeid, 
      this.alarmtype, 
      this.active,});

  Alarm.fromJson(dynamic json) {
    alarmtypeid = json['ALARMTYPEID'];
    alarmtype = json['ALARMTYPE'];
    active = json['ACTIVE'];
  }
  int? alarmtypeid;
  String? alarmtype;
  String? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ALARMTYPEID'] = alarmtypeid;
    map['ALARMTYPE'] = alarmtype;
    map['ACTIVE'] = active;
    return map;
  }

}