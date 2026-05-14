import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/auth/services/servico_auth.dart';

import 'package:cash_flow/features/event/services/event_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ServicoAuth>(() => ServicoAuth());
  getIt.registerLazySingleton<EventService>(() => EventService());
}
