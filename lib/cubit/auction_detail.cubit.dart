import 'package:bidbay_mobile/locator.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/auto_auction_info_model.dart';
import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionDetailStaticCubit extends Cubit<AuctionDetailStaticState> {
  final AuctionService service = getIt<AuctionService>();

  AuctionDetailStaticCubit() : super(const InitialAuctionDetailStaticState());

  void getAuctionDetail(String auctionId) async {
    emit(const LoadingAuctionDetailStaticState());

    final detail = await service.getAuctionDetail(auctionId);
    print("loaded");
    emit(LoadedAuctionDetailStaticState(detail));
  }

  void placeManualBid(String auctionId, int price) async {
    emit(const LoadingBidState());

    try {
      await service.placeManualBid(auctionId, price);
      emit(const PlacedManualBidState(true));
    } catch (_) {
      emit(const PlacedManualBidState(false));
    }
  }

  void getAutoBidDetail(String auctionId) async {
    emit(const LoadingBidState());

    AutoAuctionInfo data = await service.getAutoAuctionInfo(auctionId);

    emit(LoadedAutoAuctionDataState(data));
  }

  void placeAutoBid(String auctionId, AutoAuctionInfo autoAuctionInfo) async {
    emit(const LoadingBidState());

    try {
      await service.createAutoBid(auctionId, autoAuctionInfo);
      emit(const HandledAutoAuctionState(true));
    } catch (_) {
      emit(const HandledAutoAuctionState(false));
    }
  }

  void updateAutoBid(String autoAuctionId, AutoAuctionInfo autoAuctionInfo) async {
    emit(const LoadingBidState());

    try {
      await service.updateAutoBid(autoAuctionId, autoAuctionInfo);
      emit(const HandledAutoAuctionState(true));
    } catch (_) {
      emit(const HandledAutoAuctionState(false));
    }
  }

  Future<void> buyNowBid(String auctionId) async {
    emit(const LoadingBidState());

    try {
      await service.buyNowBid(auctionId);
      emit(const PlacedManualBidState(true));
    } catch (_) {
      emit(const PlacedManualBidState(false));
    }
  }

  void manualMode() {
    emit(const InManualModeState());
  }

}

@immutable
abstract class AuctionDetailStaticState extends Equatable {
  const AuctionDetailStaticState();
}

class InitialAuctionDetailStaticState extends AuctionDetailStaticState {
  const InitialAuctionDetailStaticState();

  @override
  List<Object?> get props => [];
}

class LoadingAuctionDetailStaticState extends AuctionDetailStaticState {
  const LoadingAuctionDetailStaticState();

  @override
  List<Object?> get props => [];
}

class LoadingBidState extends AuctionDetailStaticState {
  const LoadingBidState();

  @override
  List<Object?> get props => [];
}

class InManualModeState extends AuctionDetailStaticState {
  const InManualModeState();

  @override
  List<Object?> get props => [];
}

class PlacedManualBidState extends AuctionDetailStaticState {
  final bool isSuccess;

  const PlacedManualBidState(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class LoadedAutoAuctionDataState extends AuctionDetailStaticState {
  final AutoAuctionInfo autoAuctionInfo;

  const LoadedAutoAuctionDataState(this.autoAuctionInfo);

  @override
  List<Object?> get props => [autoAuctionInfo];
}

class HandledAutoAuctionState extends AuctionDetailStaticState {
  final bool isSuccess;

  const HandledAutoAuctionState(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class LoadedAuctionDetailStaticState extends AuctionDetailStaticState {
  final Auction detail;

  const LoadedAuctionDetailStaticState(this.detail);

  @override
  List<Object?> get props => [detail];
}