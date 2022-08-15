class TrackerDataModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String expense;
  final String amount;

  TrackerDataModel(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.expense,
      required this.amount});

  TrackerDataModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        date = res['date'],
        time = res['time'],
        expense = res['expense'],
        amount = res['amount'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'expense': expense,
      'amount': amount,
    };
  }
}
