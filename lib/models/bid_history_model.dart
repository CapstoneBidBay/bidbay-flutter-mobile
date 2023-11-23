import 'package:intl/intl.dart';

class BidHistoryModel {
  final int numOfBids;
  final int numOfBidders;
  final List<BidHistoryInfo> bidHistoryInfos;

  BidHistoryModel(this.numOfBids, this.numOfBidders, this.bidHistoryInfos);

  factory BidHistoryModel.fromJson(Map<String, dynamic> json){
    return BidHistoryModel(
      json['bids'],
      json['bidders'],
      json['informationBidderDTOS'].map<BidHistoryInfo>((f) => BidHistoryInfo.fromJson(f)).toList()
    );
  }
}

class BidHistoryInfo {
  final String idBidder;
  final double bidAmount;
  final DateTime bidTime;
  final String auctionType;

  BidHistoryInfo(this.idBidder, this.bidAmount, this.bidTime, this.auctionType);

  factory BidHistoryInfo.fromJson(Map<String, dynamic> jsonInput){
    return BidHistoryInfo(jsonInput['idBidder'], jsonInput['bidAmount'], DateTime.parse(jsonInput['bidTime']), jsonInput['auctionType']);
  }
}