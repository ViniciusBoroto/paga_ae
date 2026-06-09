import 'package:cash_flow/core/network/mock_api_client.dart';
import 'package:cash_flow/features/auth/services/servico_auth.dart';
import 'package:cash_flow/features/event/services/event_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<MockApiClient>(() => MockApiClient());
  getIt.registerLazySingleton<ServicoAuth>(
    () => ServicoAuth(getIt<MockApiClient>()),
  );
  getIt.registerLazySingleton<EventService>(
    () => EventService(getIt<MockApiClient>(), getIt<ServicoAuth>()),
  );
}
