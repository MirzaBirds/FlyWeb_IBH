class DataHistory {
  int id = 0;
  String date = "";
  int value = 0;

  DataHistory({required this.id,required this.date, required this.value});

  DataHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}