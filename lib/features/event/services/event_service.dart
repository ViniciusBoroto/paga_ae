import 'package:cash_flow/core/network/mock_api_client.dart';
import 'package:cash_flow/features/auth/services/servico_auth.dart';
import 'package:cash_flow/models/charge.dart';
import 'package:cash_flow/models/event.dart';
import 'package:cash_flow/models/expenditure.dart';
import 'package:flutter/material.dart';

class EventService extends ChangeNotifier {
  EventService(this._apiClient, this._authService);

  final MockApiClient _apiClient;
  final ServicoAuth _authService;
  List<Event> _events = [];
  List<Charge> _charges = [];

  List<Event> get events => List.unmodifiable(_events);

  List<Charge> get pendencies =>
      _charges.where((c) => c.paidAt == null).toList();

  double get totalOwed {
    return pendencies.fold(0.0, (sum, charge) => sum + charge.amount);
  }

  Future<void> init() async {
    try {
      final eventsResponse = await _apiClient.getList('/events');
      final chargesResponse = await _apiClient.getList('/charges');

      _events = eventsResponse
          .map((json) => Event.fromJson(json as Map<String, dynamic>))
          .toList();
      _charges = chargesResponse
          .map((json) => Charge.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      _events = [];
      _charges = [];
    }
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
    final response = await _apiClient.getMap('/events/$id');
    return Event.fromJson(response);
  }

  Future<void> createEvent({
    required String title,
    required String local,
    required String pixKey,
    required DateTime date,
  }) async {
    final response = await _apiClient.post('/events', {
      'title': title,
      'date': date.toIso8601String(),
      'creatorId': _authService.currentUser?.id,
      'local': local,
      'pixKey': pixKey,
    });
    final savedEvent = Event.fromJson(response);
    _events.insert(0, savedEvent);
    notifyListeners();
  }

  Future<void> deleteEvent(int id) async {
    await _apiClient.delete('/events/$id');
    _events.removeWhere((e) => e.id == id);
    _charges.removeWhere((c) => c.eventId == id);
    notifyListeners();
  }

  Future<void> payCharge(int chargeId) async {
    final index = _charges.indexWhere((c) => c.id == chargeId);
    if (index != -1) {
      final response = await _apiClient.patch('/charges/$chargeId/pay');
      _charges[index] = Charge.fromJson(response);
      notifyListeners();
    }
  }

  Future<Expenditure> addExpenditure({
    required String description,
    required double amount,
    required int eventId,
  }) async {
    final response = await _apiClient.post('/events/$eventId/expenditures', {
      'description': description,
      'amount': amount,
    });
    final saved = Expenditure.fromJson(response);

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
    final index = _events.indexWhere((e) => e.id == eventId);
    if (index == -1) return;

    final response = await _apiClient.patch('/events/$eventId/finalize');
    _events[index] = Event.fromJson(response);
    notifyListeners();
  }
}
