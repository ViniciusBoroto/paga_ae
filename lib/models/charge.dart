class Charge {
  final int id;
  final double amount;
  final int fromUserId;
  final int toUserId;
  final int eventId;
  final DateTime createdAt = DateTime.now();
  final DateTime? paidAt;

  Charge(
    this.id,
    this.amount,
    this.fromUserId,
    this.toUserId,
    this.eventId, {
    this.paidAt,
  });
  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      json['id'],
      json['amount'],
      json['fromUserId'],
      json['toUserId'],
      json['eventId'],
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
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
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
