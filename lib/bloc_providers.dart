import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/auction_detail.cubit.dart';
import 'package:bidbay_mobile/cubit/auction_list_cubit.dart';
import 'package:bidbay_mobile/cubit/authentication_cubit.dart';
import 'package:bidbay_mobile/cubit/bid_history_cubit.dart';
import 'package:bidbay_mobile/cubit/hot_auction_list_cubit.dart';
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
        BlocProvider(create: (_) => AuctionListStaticCubit()),
        BlocProvider(create: (_) => HotAuctionListStaticCubit()),
        BlocProvider(create: (_) => BidHistoryCubit()),
        BlocProvider(create: (_) => AuctionDetailStaticCubit())
      ];
}
