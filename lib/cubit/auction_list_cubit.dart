import 'package:bidbay_mobile/locator.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionListStaticCubit extends Cubit<AuctionListStaticState> {
  final AuctionService service = getIt<AuctionService>();

  AuctionListStaticCubit() : super(const LoadingAuctionListStaticState());

  void getYardList(String searchKey, FilterData filterData) async {
    emit(const LoadingAuctionListStaticState());

    final yards = await service.getAuctions(searchKey, filterData);

    emit(LoadedAuctionListStaticState(yards));
  }
}

@immutable
abstract class AuctionListStaticState extends Equatable {
  const AuctionListStaticState();
}

class LoadingAuctionListStaticState extends AuctionListStaticState {
  const LoadingAuctionListStaticState();

  @override
  List<Object?> get props => [];
}

class LoadedAuctionListStaticState extends AuctionListStaticState {
  final List<Auction> auctions;

  const LoadedAuctionListStaticState(this.auctions);

  @override
  List<Object?> get props => [auctions];
}