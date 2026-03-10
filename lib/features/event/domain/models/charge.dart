class Charge {
  final int id;
  final double amount;
  final int fromUserId;
  final int toUserId;
  final int eventId;
  final DateTime? createdAt;
  final DateTime? paidAt;

  const Charge({
    required this.id,
    required this.amount,
    required this.fromUserId,
    required this.toUserId,
    required this.eventId,
    this.createdAt,
    this.paidAt,
  });

  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      fromUserId: (json['fromUserId'] as num).toInt(),
      toUserId: (json['toUserId'] as num).toInt(),
      eventId: (json['eventId'] as num).toInt(),
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'] as String)
              : null,
      paidAt:
          json['paidAt'] != null
              ? DateTime.parse(json['paidAt'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'eventId': eventId,
      'paidAt': paidAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  Charge copyWith({
    int? id,
    double? amount,
    int? fromUserId,
    int? toUserId,
    int? eventId,
    DateTime? createdAt,
    DateTime? paidAt,
  }) {
    return Charge(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      eventId: eventId ?? this.eventId,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Charge &&
        other.id == id &&
        other.amount == amount &&
        other.fromUserId == fromUserId &&
        other.toUserId == toUserId &&
        other.eventId == eventId &&
        other.createdAt == createdAt &&
        other.paidAt == paidAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    fromUserId,
    toUserId,
    eventId,
    createdAt,
    paidAt,
  );
}
