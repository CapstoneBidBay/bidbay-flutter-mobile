import 'package:bidbay_mobile/common/contract.dart';
import 'package:bidbay_mobile/common/util_functions.dart';
import 'package:flutter/material.dart';

class AuctionTypeBadge extends StatelessWidget {
  final String auctionType;

  const AuctionTypeBadge({Key? key, required this.auctionType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = auctionType == IMMEDIATE_AUCTION_TYPE ? const Color.fromARGB(255, 53, 92, 133) : Color.fromARGB(255, 29, 106, 60);
    return Badge(
      label: Text(mapAuctionTypeToVietnameseOutput(auctionType)),
      largeSize: 20,
      //padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      backgroundColor: color,
    );
}
}
