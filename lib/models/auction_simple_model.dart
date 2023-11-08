import 'dart:convert';

import 'package:bidbay_mobile/common/values.dart';

class Auction {
  final String id;
  final int timeRemain;
  final String modelType;
  final double currentPrice;
  final double startPrice;
  final double buyNowPrice;
  final double jump;
  final int numOfBids;
  final int numOfAuctioneers;
  final int minimumAuctioneers;

  final String productName;
  final String productDescription;
  final String productBrandName;
  final List<String> images;

  Auction(this.id, this.timeRemain, this.modelType,
  this.currentPrice, this.startPrice, this.buyNowPrice,
  this.jump, this.numOfBids, this.numOfAuctioneers, 
  this.minimumAuctioneers, this.productName, this.productDescription, this.productBrandName, this.images);

  factory Auction.fromJson(Map<String, dynamic> jsonInput) {
    // MAP FROM JSON LOGIC HERE

    List<dynamic> productImages = jsonInput["product"]["imageUrls"];

    return Auction(
      jsonInput['id'], 
      jsonInput['timeLeft'] as int, 
      jsonInput['modelType'], 
      jsonInput['highestPrice'] as double, 
      jsonInput['startPrice'] as double,
      jsonInput['buyNowPrice'] as double,
      jsonInput['jump'] as double,
      jsonInput['numberOfBids'] as int,
      jsonInput['numberOfAuctioneers'] as int,
      jsonInput['minimumAuctioneers'] as int,
      jsonInput["product"]["name"].toString(),
      jsonInput["product"]["description"].toString(),
      jsonInput["product"]["brand"]["name"].toString(),
      productImages == null ? [NO_IMAGE_URL] : productImages.map((img)=> img == null ? NO_IMAGE_URL : img as String).toList()
    );
  }
}