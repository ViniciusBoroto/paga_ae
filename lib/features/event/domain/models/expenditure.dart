class Expenditure {
  final int id;
  final String description;
  final double amount;
  final int eventId;

  const Expenditure({
    required this.id,
    required this.description,
    required this.amount,
    required this.eventId,
  });

  factory Expenditure.fromJson(Map<String, dynamic> json) {
    return Expenditure(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      eventId: (json['eventId'] as num).toInt(),
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

  Expenditure copyWith({
    int? id,
    String? description,
    double? amount,
    int? eventId,
  }) {
    return Expenditure(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      eventId: eventId ?? this.eventId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Expenditure &&
        other.id == id &&
        other.description == description &&
        other.amount == amount &&
        other.eventId == eventId;
  }

  @override
  int get hashCode => Object.hash(id, description, amount, eventId);
}
