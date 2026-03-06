class Expenditure {
  final int id;
  final String description;
  final double amount;
  final int eventId;

  Expenditure(this.id, this.description, this.amount, this.eventId);

  factory Expenditure.fromJson(Map<String, dynamic> json) {
    return Expenditure(
      json['id'],
      json['description'],
      json['amount'],
      json['eventId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'eventId': eventId,
    };
  }
}
