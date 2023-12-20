import 'dart:convert';
import 'package:bidbay_mobile/common/static_values.dart';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/auto_auction_info_model.dart';
import 'package:bidbay_mobile/models/bid_history_model.dart';
import 'package:bidbay_mobile/models/brand_model.dart';
import 'package:bidbay_mobile/models/category_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/service/http/my_http_client.dart';
import 'package:http/http.dart' as http;

class AuctionService {
  Future<List<Auction>> getHotAuctions() async {
    String serviceUrl = "$apiServer/guest/auctions-guest/list-descending-priority-auction?page=1&size=100";
    final response = await MyHttpClient.getClient().get(Uri.parse(serviceUrl));
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      if(responseBody['data'] != null){
        return responseBody['data'].map((data) => Auction.fromJson(data)).toList().cast<Auction>();
      }
    }
    return [];
  }

  Future<List<Auction>> getAuctions(String searchKey, FilterData filterData) async {
    String serviceUrl = "$apiServer/guest/auctions-guest?page=1&size=1000&";
    String queryBuilt = _buildQueryParams(searchKey.trim(), filterData);
    serviceUrl += queryBuilt;
    // build query param
    print("Check in 1");
    print(serviceUrl);
    final response = await MyHttpClient.getClient().get(Uri.parse(serviceUrl));
    print("Check in 2");
    if(response.statusCode >= 200 && response.statusCode < 300){
      print(response.body);
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      if(responseBody['data'] != null){
        return responseBody['data'].map((data) => Auction.fromJson(data)).toList().cast<Auction>();
      }
    }
    return [];
  }
  String _buildQueryParams(String searchKey, FilterData data){
    String output = "query=status:IN_PROCESS";
    // if(data.auctionType != null){
    //   output += data.auctionType.toString();
    // }
    if(data.brandId != null && data.brandId != ""){
      output += ";auctionProduct_brandId:${data.brandId.toString()}";
    }
    if(data.categoryId != null && data.categoryId != ""){
      output += ";auctionProduct_categoryId:${data.categoryId.toString()}";
    }
    if(data.priceStart != null && data.priceStart! >= 0){
      output += ";startPrice>${data.priceStart!}";
    }
    if(data.priceEnd != null && data.priceEnd! >= 0){
      output += ";startPrice<${data.priceEnd!}";
    }
    if(searchKey != ""){
      output += ";product_name~$searchKey";
    }
    if(data.sort != null && data.sort != ""){
      output += "&sort=${data.sort!}";
    }
    return output == "query=" ? "" : output;
  }

  Future<void> placeManualBid(String auctionId, int price) async {
    String serviceUrl = "$apiServer/auctions/buyer/manual-auction";
    final response = await MyHttpClient.getClient().post(Uri.parse(serviceUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
      jsonEncode(<String, dynamic> {
        "auctionAmount" : price.toString(),
        "auctionId": auctionId
      })
    );
    //print(response.body);
    if(response.statusCode != 201){
      throw Exception("Place bid error.");
    }
  }

  Future<void> buyNowBid(String auctionId) async {
    String serviceUrl = "$apiServer/auctions/$auctionId/direct-purchase-auction";
    final response = await MyHttpClient.getClient().post(Uri.parse(serviceUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    //print(response.body);
    if(response.statusCode != 201){
      throw Exception("Place bid error.");
    }
  }

  Future<AutoAuctionInfo> getAutoAuctionInfo(String auctionId) async {
    String serviceUrl = "$apiServer/auctions/$auctionId/auctionAutoInfo-detail";
    final response = await MyHttpClient.getClient().get(Uri.parse(serviceUrl));
    if(response.statusCode == 200){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody['data'] != null ? AutoAuctionInfo.fromJson(responseBody['data'][0]) : AutoAuctionInfo.noData();
    }
    throw Exception('Get data error');
  }

  Future<void> createAutoBid(String auctionId, AutoAuctionInfo autoAuctionInfo) async {
    String serviceUrl = "$apiServer/auctions/buyer/add-auto-auction-info/$auctionId";
    final response = await MyHttpClient.getClient().post(
      Uri.parse(serviceUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
        jsonEncode(<String, dynamic> {
          "deltaPrice" : autoAuctionInfo.jump.toString(),
          "deltaTime": autoAuctionInfo.delayTime,
          "maxPrice": autoAuctionInfo.maxPrice.toString()
        })
      );
    if(response.statusCode != 200){
      throw Exception("Put error");
    }
  }

  Future<void> updateAutoBid(String autoAuctionId, AutoAuctionInfo autoAuctionInfo) async {
    String serviceUrl = "$apiServer/auctions/buyer/edit-auto-auction-info/$autoAuctionId";
    final response = await MyHttpClient.getClient().put(
      Uri.parse(serviceUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
        jsonEncode(<String, dynamic> {
          "deltaPrice" : autoAuctionInfo.jump.toString(),
          "deltaTime": autoAuctionInfo.delayTime,
          "maxPrice": autoAuctionInfo.maxPrice.toString()
        })
      );
    if(response.statusCode != 200){
      throw Exception("Put error");
    }
  }

  Future<Auction> getAuctionDetail(String auctionId) async {
    String serviceUrl = "$apiServer/guest/$auctionId/auction-detail-guest";
    final response = await http.get(Uri.parse(serviceUrl));
    if(response.statusCode == 200){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return Auction.fromJson(responseBody['data']);
    }
    throw Exception('Get data error');
  }

  Future<BidHistoryModel> getBidHistory(String auctionId) async {
    String serviceUrl = "$apiServer/guest/auction-guest/$auctionId";
    final response = await http.get(Uri.parse(serviceUrl));
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      print(responseBody);
      return BidHistoryModel.fromJson(responseBody['data']);
    }
    return BidHistoryModel(0, 0, []);
  }

  Future<List<BrandModel>> getBrands() async {
    String serviceUrl = "$apiServer/guest/brands-guest?page=1&size=1000";
    final response = await http.get(Uri.parse(serviceUrl));
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      brandList = responseBody['data'].map((data) => BrandModel.fromJson(data)).toList().cast<BrandModel>();
      return brandList;
    }
    return [];
  }
  Future<List<CategoryModel>> getCategories() async {
    String serviceUrl = "$apiServer/guest/categories-guest?page=1&size=1000";
    final response = await http.get(Uri.parse(serviceUrl));
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      categoryList = responseBody['data'].map((data) => CategoryModel.fromJson(data)).toList().cast<CategoryModel>();
      return categoryList;
    }
    return [];
  }
}