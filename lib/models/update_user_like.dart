class UpdateUserLike {
  UpdateUserLike({
    required this.PhoneNo,
    required this.IdeaId,
  });
  late final String PhoneNo;
  late final String IdeaId;

  UpdateUserLike.fromJson(Map<String, dynamic> json) {
    PhoneNo = json['PhoneNo'];
    IdeaId = json['IdeaId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PhoneNo'] = PhoneNo;
    _data['IdeaId'] = IdeaId;
    return _data;
  }
}
