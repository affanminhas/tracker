// This is your model class where we create model for our notes that how will it take variables
// in constructor and than convert it to map and secondly we have function which is converting
// map into object.

class TrackerModel {
  int? id;
  String title;
  String description;
  String date;
  String time;
  String expense;
  String amount;

  TrackerModel(
      {this.id,
        required this.title,
        required this.description,
        required this.date,
        required this.time,
        required this.expense,
        required this.amount});

  // ---- Mapping our variables -----
  TrackerModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date'],
        time = map['time'],
        expense = map['expense'],
        amount = map['amount'];

  // ---- Setting it from map to object ----
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'expense': expense,
      'amount': amount
    };
  }
}
