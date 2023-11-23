class AutoAuctionInfo {
  final String? id;
  final int maxPrice;
  final int delayTime;
  final int jump;

  AutoAuctionInfo(this.id, this.maxPrice, this.delayTime, this.jump);

  factory AutoAuctionInfo.fromJson(Map<String, dynamic> jsonInput){
    double maxPriceDouble = jsonInput['maxPrice'] as double;
    double jumpDouble = jsonInput['deltaPrice'] as double;
    
    return AutoAuctionInfo(jsonInput['id'], maxPriceDouble.floor(), jsonInput['deltaTime'], jumpDouble.floor());
  }
  factory AutoAuctionInfo.noData(){
    return AutoAuctionInfo(null, 0, 0, 0);
  }
}