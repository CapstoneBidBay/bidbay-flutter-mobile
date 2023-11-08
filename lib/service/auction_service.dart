import 'dart:convert';

import 'package:bidbay_mobile/common/static_values.dart';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/brand_model.dart';
import 'package:bidbay_mobile/models/category_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/service/http/my_http_client.dart';
import 'package:http/http.dart' as http;

class AuctionService {
  Future<List<Auction>> getAuctions(String searchKey, FilterData filterData) async {
    String serviceUrl = "$apiServer/auctions?page=1&size=1000&";
    String queryBuilt = _buildQueryParams(searchKey.trim(), filterData);
    serviceUrl += queryBuilt;
    // build query param
    final response = await MyHttpClient.getClient().get(Uri.parse(serviceUrl));
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody['data'].map((data) => Auction.fromJson(data)).toList().cast<Auction>();
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