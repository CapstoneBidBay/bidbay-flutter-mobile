import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:bidbay_mobile/service/service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerFactory(() => Service());
  getIt.registerFactory(() => AuctionService());
}
