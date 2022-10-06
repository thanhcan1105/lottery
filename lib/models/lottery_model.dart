class LotteryModel {
  int? id;
  String? provinces;
  String? ticketType;
  String? date;
  int? giai;
  String? result;
  String? createdAt;
  String? updatedAt;

  LotteryModel(
      {this.id,
      this.provinces,
      this.ticketType,
      this.date,
      this.giai,
      this.result,
      this.createdAt,
      this.updatedAt});

  LotteryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinces = json['provinces'];
    ticketType = json['ticket_type'];
    date = json['date'];
    giai = json['giai'];
    result = json['result'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provinces'] = this.provinces;
    data['ticket_type'] = this.ticketType;
    data['date'] = this.date;
    data['giai'] = this.giai;
    data['result'] = this.result;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
