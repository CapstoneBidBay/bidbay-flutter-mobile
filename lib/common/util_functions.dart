import 'package:bidbay_mobile/common/contract.dart';
import 'package:intl/intl.dart';

String formatCurrency(double input){
  final currencyFormat = NumberFormat.currency(locale: 'vi-VN', symbol: 'đ', decimalDigits: 0);
  return currencyFormat.format(input);
}
String mapAuctionTypeToVietnameseOutput(String auctionType){
  if(auctionType == INTERMEDIATE_AUCTION_TYPE){
    return "Trung gian qua hệ thống";
  }
  return "Tự trao đổi";
}