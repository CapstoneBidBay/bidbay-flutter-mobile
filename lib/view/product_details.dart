// ignore_for_file: prefer_const_constructors

import 'package:bidbay_mobile/common/color.dart';
import 'package:bidbay_mobile/common/contract.dart';
import 'package:bidbay_mobile/common/util_functions.dart';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/widgets/auction_type_badge.dart';
import 'package:bidbay_mobile/widgets/auto_auction_form.dart';
import 'package:bidbay_mobile/widgets/manual_auction_form.dart';
import 'package:bidbay_mobile/widgets/star_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetailsView extends StatelessWidget {
  final Auction auction;

  const ProductDetailsView({Key? key, required this.auction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          builder: (BuildContext context) {
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
                            bidType == AUTO_PLACE_BID ?
                            AutoAuctionForm(
                              onSubmit: (maxPrice, delayTime, jump){
                                print("Max price: ${maxPrice}");
                                print("Delay time: ${delayTime}");
                                print("Jump: ${jump}");
                              },
                              maxPrice: 100000,
                              delayTime: 2,
                              jump: 10000,
                            ) :
                            ManualAuctionForm(onSubmit: (data){
                              print("Place bid: ${data}");
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    void showHistory() {
      showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          builder: (BuildContext context) {
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
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("9xxx1(84)")),
                            DataCell(Text("100.000")),
                            DataCell(Text("Tự động")),
                          ]),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBgColor,
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
            onPressed: () {},
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
                auction.images.first,
                fit: BoxFit.cover),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                                child: AuctionTypeBadge(auctionType: auction.modelType,)),
                            IconButton(
                              onPressed: () {
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
                              auction.productName,
                              style: GoogleFonts.poppins(
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
                          auction.productDescription,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giá hiện tại:',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 4, 80, 244)),
                            ),
                            Text(
                              formatCurrency(auction.currentPrice == 0 ? auction.startPrice : auction.currentPrice),
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 243, 57, 57)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giá mua ngay:',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 4, 80, 244)),
                            ),
                            Text(
                              formatCurrency(auction.buyNowPrice),
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 243, 57, 57)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Đặt lần cuối bởi 94xxxxxxxxxxx - 2/11/2023 20:00:00',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
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
                      color: AppColors.kGreyColor,
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
        color: Colors.white,
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
                    style: GoogleFonts.poppins(
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
                    'Đấu giá thủ công',
                    style: GoogleFonts.poppins(
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
                    style: GoogleFonts.poppins(
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
  }
}
