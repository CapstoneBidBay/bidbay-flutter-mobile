import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/authentication_cubit.dart';
import 'package:bidbay_mobile/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  BlocProviders._();
  static get getProviders => [
        // BlocProvider(create: (_) => YardCubit()),
        // BlocProvider(create: (_) => YardListStaticCubit()),
        // BlocProvider(create: (_) => DistrictAndProvinceCubit()),
        // BlocProvider(create: (_) => YardListCubit()),
        // BlocProvider(create: (_) => IncomingMatchCubit()),
        // BlocProvider(create: (_) => SlotsCubit()),
        // BlocProvider(create: (_) => BookingSlotsCubit()),
        BlocProvider(create: (_) => AuthenticationCubit(userService: UserService(apiUrl: apiServer, jwtSecret: jwtSecret))),
      ];
}
