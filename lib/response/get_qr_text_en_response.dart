class GetQrTextEnResponse {
  GetQrTextEnResponse({
      this.code, 
      this.text, 
      this.msg,});

  GetQrTextEnResponse.fromJson(dynamic json) {
    code = json['code'];
    text = json['Text'];
    msg = json['msg'];
  }
  String? code;
  String? text;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['Text'] = text;
    map['msg'] = msg;
    return map;
  }

}