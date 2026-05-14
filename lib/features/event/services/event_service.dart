import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/enums.dart';
import 'package:cash_flow/models/charge.dart';
import 'package:flutter/material.dart';

class EventService extends ChangeNotifier {
  final List<Event> _events = [];
  final List<Charge> _charges = [];

  EventService() {
    // Dados iniciais
    _events.add(Event(
      id: 1,
      title: 'Churrasco do Zé',
      date: DateTime.now().add(const Duration(days: 10)),
      status: EventStatus.upcoming,
      participants: [],
      createdAt: DateTime.now(),
    ));
    _events.add(Event(
      id: 2,
      title: 'Aniversário da Susan',
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: EventStatus.finalized,
      participants: [],
      createdAt: DateTime.now(),
    ));

    _charges.add(Charge(id: 1, amount: 75.0, fromUserId: 1, toUserId: 2, eventId: 1, createdAt: DateTime.now()));
    _charges.add(Charge(id: 2, amount: 100.0, fromUserId: 1, toUserId: 3, eventId: 2, createdAt: DateTime.now()));
  }

  List<Event> get events => List.unmodifiable(_events);
  
  List<Charge> get pendencies => _charges.where((c) => c.paidAt == null).toList();

  double get totalOwed {
    return pendencies.fold(0.0, (sum, charge) => sum + charge.amount);
  }

  Event? getEventById(int id) {
    try {
      return _events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  void createEvent({
    required String title,
    required String local,
    required String pixKey,
    required DateTime date,
  }) {
    final newEvent = Event(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      date: date,
      status: EventStatus.upcoming,
      participants: [],
      createdAt: DateTime.now(),
    );

    _events.add(newEvent);
    notifyListeners();
  }

  void deleteEvent(int id) {
    _events.removeWhere((e) => e.id == id);
    _charges.removeWhere((c) => c.eventId == id);
    notifyListeners();
  }

  void payCharge(int chargeId) {
    final index = _charges.indexWhere((c) => c.id == chargeId);
    if (index != -1) {
      _charges[index] = _charges[index].copyWith(paidAt: DateTime.now());
      notifyListeners();
    }
  }
}
