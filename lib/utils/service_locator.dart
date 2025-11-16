import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setup() {
  // getIt.registerSingleton<ApiService>(ApiService(Dio()));
  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
}
