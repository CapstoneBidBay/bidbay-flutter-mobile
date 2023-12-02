import 'package:bidbay_mobile/locator.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotAuctionListStaticCubit extends Cubit<HotAuctionListStaticState> {
  final AuctionService service = getIt<AuctionService>();

  HotAuctionListStaticCubit() : super(const LoadingHotAuctionListStaticState());

  void getYardList() async {
    emit(const LoadingHotAuctionListStaticState());

    final yards = await service.getHotAuctions();

    emit(LoadedHotAuctionListStaticState(yards));
  }
}

@immutable
abstract class HotAuctionListStaticState extends Equatable {
  const HotAuctionListStaticState();
}

class LoadingHotAuctionListStaticState extends HotAuctionListStaticState {
  const LoadingHotAuctionListStaticState();

  @override
  List<Object?> get props => [];
}

class LoadedHotAuctionListStaticState extends HotAuctionListStaticState {
  final List<Auction> auctions;

  const LoadedHotAuctionListStaticState(this.auctions);

  @override
  List<Object?> get props => [auctions];
}