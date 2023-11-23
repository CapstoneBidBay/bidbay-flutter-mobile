// ignore_for_file: prefer_const_constructors
import 'package:bidbay_mobile/common/util_functions.dart';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/auction_detail.cubit.dart';
import 'package:bidbay_mobile/cubit/bid_history_cubit.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/auto_auction_info_model.dart';
import 'package:bidbay_mobile/models/bid_history_model.dart';
import 'package:bidbay_mobile/utils/toast_message.dart';
import 'package:bidbay_mobile/widgets/auction_type_badge.dart';
import 'package:bidbay_mobile/widgets/auto_auction_form.dart';
import 'package:bidbay_mobile/widgets/loading.dart';
import 'package:bidbay_mobile/widgets/manual_auction_form.dart';
import 'package:bidbay_mobile/widgets/star_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetailsView extends StatefulWidget {
  final Auction auction;

  ProductDetailsView({Key? key, required this.auction}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late BidHistoryModel bidHistoryModel;
  AutoAuctionInfo autoAuctionInfo = AutoAuctionInfo.noData();
  late Auction auctionState;

  @override
  void initState(){
    auctionState = widget.auction;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDetailStaticCubit, AuctionDetailStaticState>(builder: (context, state) {
      if(state is LoadingAuctionDetailStaticState){
        return Loading();
      }
      if(state is LoadedAuctionDetailStaticState){
        auctionState = state.detail;
      }
      return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(
              Ionicons.bag_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(
                auctionState.images.first,
                fit: BoxFit.cover),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(31, 129, 127, 127),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                child: AuctionTypeBadge(auctionType: auctionState.modelType,)),
                            IconButton(
                              onPressed: () {
                                BidHistoryCubit bidHistoryCubit = BlocProvider.of<BidHistoryCubit>(context);
                                bidHistoryCubit.getHistory(auctionState.id);
                                showHistory();
                              },
                              icon: const Icon(
                                Ionicons.document_text_outline,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              auctionState.productName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        StarRatingBar(rating: 5, size: 18),
                        const SizedBox(height: 15),
                        Text(
                          auctionState.productDescription,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số người đặt giá tối thiểu:',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 4, 80, 244),
                                    ),
                                  ),
                                  Text(
                                    auctionState.minimumAuctioneers.toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 243, 57, 57),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giá hiện tại:',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 4, 80, 244),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(auctionState.currentPrice == 0
                                        ? auctionState.startPrice
                                        : auctionState.currentPrice),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 243, 57, 57),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bước nhảy:',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 4, 80, 244),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(auctionState.jump),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 243, 57, 57),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giá mua ngay:',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 4, 80, 244),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(auctionState.buyNowPrice),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 243, 57, 57),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                auctionState.lastBidDetail,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Color.fromARGB(31, 129, 127, 127),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showConfirmDialog();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 207, 65, 49),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  onPlaceBidClick(MANUAL_PLACE_BID);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 40, 139, 37),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Đấu giá',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  onPlaceBidClick(AUTO_PLACE_BID);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 73, 187),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Đấu giá tự động',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
  }
  void showConfirmDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn có chắc chắn muốn mua ngay sản phẩm này không?'),
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                //
              },
            ),
          ],
        );
      },
    );
  }
  void onPlaceBidClick(String bidType) {
    AuctionDetailStaticCubit auctionDetailStaticCubit = BlocProvider.of<AuctionDetailStaticCubit>(context);
    if(bidType == AUTO_PLACE_BID){
      auctionDetailStaticCubit.getAutoBidDetail(auctionState.id);
    } else {
      auctionDetailStaticCubit.manualMode();
    }
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<AuctionDetailStaticCubit, AuctionDetailStaticState>(builder: (context, state) {
          if(state is LoadingBidState){
            return Loading();
          }
          if(state is LoadedAutoAuctionDataState){
            return buildAutoAuctionBid(state.autoAuctionInfo);
          }
          if(state is PlacedManualBidState || state is HandledAutoAuctionState){
            if(state is PlacedManualBidState){
              if(state.isSuccess){
                ToastMessageHelper.toastSuccessShortMessage("Đặt đấu giá thành công");
              } else {
                ToastMessageHelper.toastErrorShortMessage("Đặt đấu giá thất bại, vui lòng thử lại");
              }
            } else if(state is HandledAutoAuctionState) {
              if(state.isSuccess){
                ToastMessageHelper.toastSuccessShortMessage("Đặt đấu giá thành công");
              } else {
                ToastMessageHelper.toastErrorShortMessage("Đặt đấu giá thất bại, vui lòng thử lại");
              }
            }
            auctionDetailStaticCubit.getAuctionDetail(auctionState.id);
            Navigator.pop(context);
          }
          return buildManualAuctionInfo();
        });
      }
    );
  }
  void showHistory() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<BidHistoryCubit, BidHistoryState>(builder: (context, state) {
          if(state is LoadingBidHistoryState){
            return Loading();
          }
          if(state is LoadedBidHistoryState){
            bidHistoryModel = state.bidHistoryModel;
          }
            return Container(
            color: Color.fromARGB(19, 119, 127, 143),
            height: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Lịch sử đấu giá',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 15,),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('SĐT')),
                        DataColumn(label: Text('Giá')),
                        DataColumn(label: Text('Loại')),
                      ],
                      rows: bidHistoryModel.bidHistoryInfos.map(
                        (info) => DataRow(cells: [
                          DataCell(Text(info.idBidder)),
                          DataCell(Text(info.bidAmount.toStringAsFixed(0))),
                          DataCell(Text(info.auctionType)),
                        ])).toList()
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
    }
  Widget buildAutoAuctionBid(AutoAuctionInfo autoAuctionInfo){
    return Container(
      color: Color.fromARGB(19, 119, 127, 143),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Tiến hành đấu giá',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5),
                      bottom: BorderSide(width: 0.5))),
              // height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AutoAuctionForm(
                      onSubmit: (autoAuctionId, maxPrice, delayTime, jump){
                        AuctionDetailStaticCubit auctionDetailStaticCubit = BlocProvider.of<AuctionDetailStaticCubit>(context);
                        if(autoAuctionId != null){
                          auctionDetailStaticCubit.updateAutoBid(autoAuctionId, AutoAuctionInfo(autoAuctionId, maxPrice, delayTime, jump));
                        } else {
                          auctionDetailStaticCubit.placeAutoBid(auctionState.id, AutoAuctionInfo(null, maxPrice, delayTime, jump));
                        }
                      },
                      autoAuctionInfo: autoAuctionInfo,
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildManualAuctionInfo() {
    return Container(
      color: Color.fromARGB(19, 119, 127, 143),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Tiến hành đấu giá',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5),
                      bottom: BorderSide(width: 0.5))),
              // height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ManualAuctionForm(onSubmit: (data){
                      AuctionDetailStaticCubit auctionDetailStaticCubit = BlocProvider.of<AuctionDetailStaticCubit>(context);
                      auctionDetailStaticCubit.placeManualBid(auctionState.id, data);
                    }),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
