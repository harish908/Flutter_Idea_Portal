import 'dart:convert';

class Idea {
  late final String Id;
  late final String PhoneNo;
  late final String Title;
  late final String Description;
  late final String Date;
  late final int Likes;
  Idea();

  Idea.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    PhoneNo = json['PhoneNo'];
    Title = json['Title'];
    Description = json['Description'];
    Date = json['Date'];
    Likes = json['Likes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['PhoneNo'] = PhoneNo;
    _data['Title'] = Title;
    _data['Description'] = Description;
    _data['Date'] = Date;
    _data['Likes'] = Likes;
    return _data;
  }

  static List<Idea> ObjectFromJson(String str) =>
      List<Idea>.from(json.decode(str).map((x) => Idea.fromJson(x)));

  static String ObjectToJson(List<Idea> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
