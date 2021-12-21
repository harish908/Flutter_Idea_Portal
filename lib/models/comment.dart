import 'dart:convert';

class Comment {
  Comment({
    required this.Id,
    required this.comments,
  });
  late final String Id;
  late final List<Comments> comments;

  Comment.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    comments =
        List.from(json['Comments']).map((e) => Comments.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['Comments'] = comments.map((e) => e.toJson()).toList();
    return _data;
  }

  // static Comment ObjectFromJson(String str) =>
  //     json.decode(str).map((x) => Comment.fromJson(x));

  // static String ObjectToJson(Comment data) => json.encode(data.toJson());
}

class Comments {
  Comments({
    required this.Message,
    required this.Name,
  });
  late final String Message;
  late final String Name;

  Comments.fromJson(Map<String, dynamic> json) {
    Message = json['Message'];
    Name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = Message;
    _data['Name'] = Name;
    return _data;
  }

  // static Comments ObjectFromJson(String str) =>
  //     json.decode(str).map((x) => Comments.fromJson(x));

  // static String ObjectToJson(Comments data) => json.encode(data.toJson());
}
