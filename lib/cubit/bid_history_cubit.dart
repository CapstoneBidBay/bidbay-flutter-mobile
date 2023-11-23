import 'package:bidbay_mobile/locator.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/bid_history_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BidHistoryCubit extends Cubit<BidHistoryState> {
  final AuctionService service = getIt<AuctionService>();

  BidHistoryCubit() : super(const LoadingBidHistoryState());

  void getHistory(String auctionId) async {
    emit(const LoadingBidHistoryState());

    final data = await service.getBidHistory(auctionId);

    emit(LoadedBidHistoryState(data));
  }
}

@immutable
abstract class BidHistoryState extends Equatable {
  const BidHistoryState();
}

class LoadingBidHistoryState extends BidHistoryState {
  const LoadingBidHistoryState();

  @override
  List<Object?> get props => [];
}

class LoadedBidHistoryState extends BidHistoryState {
  final BidHistoryModel bidHistoryModel;

  const LoadedBidHistoryState(this.bidHistoryModel);

  @override
  List<Object?> get props => [bidHistoryModel];
}