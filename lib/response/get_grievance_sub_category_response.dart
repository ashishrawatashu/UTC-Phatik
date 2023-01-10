class Get_grievance_sub_category_response {
  Get_grievance_sub_category_response({
      this.code, 
      this.subCategory, 
      this.msg,});

  Get_grievance_sub_category_response.fromJson(dynamic json) {
    code = json['code'];
    if (json['SubCategory'] != null) {
      subCategory = [];
      json['SubCategory'].forEach((v) {
        subCategory?.add(SubCategory.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  String? code;
  List<SubCategory>? subCategory;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    if (subCategory != null) {
      map['SubCategory'] = subCategory?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class SubCategory {
  SubCategory({
      this.subcatid, 
      this.subcatname,});

  SubCategory.fromJson(dynamic json) {
    subcatid = json['subcatid'];
    subcatname = json['subcatname'];
  }
  int? subcatid;
  String? subcatname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subcatid'] = subcatid;
    map['subcatname'] = subcatname;
    return map;
  }

}