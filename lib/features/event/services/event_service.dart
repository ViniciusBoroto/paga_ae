import 'package:cash_flow/core/utils/database.dart';
import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/enums.dart';
import 'package:cash_flow/models/charge.dart';
import 'package:cash_flow/models/expenditure.dart';
import 'package:flutter/material.dart';

class EventService extends ChangeNotifier {
  List<Event> _events = [];
  List<Charge> _charges = [];

  List<Event> get events => List.unmodifiable(_events);

  List<Charge> get pendencies => _charges.where((c) => c.paidAt == null).toList();

  double get totalOwed {
    return pendencies.fold(0.0, (sum, charge) => sum + charge.amount);
  }

  Future<void> init() async {
    final dbEvents = await DatabaseHelper.obterTodosEventos();
    final dbCharges = await DatabaseHelper.obterTodasCobrancas();

    _events = [];
    for (final event in dbEvents) {
      final participants = await DatabaseHelper.obterParticipantesDoEvento(event.id);
      final expenditures = await DatabaseHelper.obterDespesasDoEvento(event.id);
      _events.add(event.copyWith(
        participants: participants,
        expenditures: expenditures,
      ));
    }

    _charges = dbCharges;
    notifyListeners();
  }

  Event? getEventById(int id) {
    try {
      return _events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<Event?> getEventByIdFromDb(int id) async {
    final event = await DatabaseHelper.obterEventoPorId(id);
    if (event == null) return null;
    final participants = await DatabaseHelper.obterParticipantesDoEvento(id);
    final expenditures = await DatabaseHelper.obterDespesasDoEvento(id);
    return event.copyWith(participants: participants, expenditures: expenditures);
  }

  Future<void> createEvent({
    required String title,
    required String local,
    required String pixKey,
    required DateTime date,
  }) async {
    final newEvent = Event(
      id: 0,
      title: title,
      date: date,
      status: EventStatus.upcoming,
      participants: [],
      createdAt: DateTime.now(),
    );

    final id = await DatabaseHelper.inserirEvento(newEvent);
    final savedEvent = newEvent.copyWith(id: id);
    _events.insert(0, savedEvent);
    notifyListeners();
  }

  Future<void> deleteEvent(int id) async {
    await DatabaseHelper.deletarEvento(id);
    _events.removeWhere((e) => e.id == id);
    _charges.removeWhere((c) => c.eventId == id);
    notifyListeners();
  }

  Future<void> payCharge(int chargeId) async {
    final index = _charges.indexWhere((c) => c.id == chargeId);
    if (index != -1) {
      final paid = _charges[index].copyWith(paidAt: DateTime.now());
      await DatabaseHelper.atualizarCobranca(paid);
      _charges[index] = paid;
      notifyListeners();
    }
  }

  Future<Expenditure> addExpenditure({
    required String description,
    required double amount,
    required int eventId,
  }) async {
    final exp = Expenditure(id: 0, description: description, amount: amount, eventId: eventId);
    final id = await DatabaseHelper.inserirDespesa(exp);
    final saved = exp.copyWith(id: id);

    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      final event = _events[eventIndex];
      _events[eventIndex] = event.copyWith(
        expenditures: [...event.expenditures, saved],
      );
    }
    notifyListeners();
    return saved;
  }

  Future<void> finalizeEvent(int eventId) async {
    final event = getEventById(eventId);
    if (event == null) return;

    final finalized = event.copyWith(
      status: EventStatus.finalized,
      finalizedAt: DateTime.now(),
    );
    await DatabaseHelper.atualizarEvento(finalized);

    final index = _events.indexWhere((e) => e.id == eventId);
    if (index != -1) {
      _events[index] = finalized;
    }
    notifyListeners();
  }
}
