import 'package:bidbay_mobile/common/util_functions.dart';
import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/view/product_details.dart';
import 'package:bidbay_mobile/widgets/auction_type_badge.dart';
import 'package:bidbay_mobile/widgets/currency_text.dart';
import 'package:bidbay_mobile/widgets/star_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class AuctionCard extends StatefulWidget {
  final Auction auctionData;

  const AuctionCard({Key? key, required this.auctionData}) : super(key: key);

  @override
  _AuctionCardState createState() => _AuctionCardState();
}

class _AuctionCardState extends State<AuctionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void viewDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailsView(auction: widget.auctionData),
      ),
    );
  }

  Widget onImageLoading(context, Widget child, ImageChunkEvent? progress) {
    if (progress == null) return child;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.6;
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: animationController, curve: Curves.easeInToLinear),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: cardWidth,
        child: InkWell(
          onTap: viewDetail,
          customBorder: roundedRect16,
          child: Stack(
            children: <Widget>[
              buildInfoCard(context, cardWidth),
              //buildImageCard(cardWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(context, cardWidth) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 3,
        shape: roundedRect12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildImageCard(cardWidth),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: CurrencyText(currency: formatCurrency(widget.auctionData.currentPrice == 0 ? widget.auctionData.startPrice : widget.auctionData.currentPrice)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: AuctionTypeBadge(auctionType: widget.auctionData.modelType),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageCard(cardWidth) {
    return Container(
      width: cardWidth,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        shape: roundedRect16,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.network(
                    widget.auctionData.images.first,
                    fit: BoxFit.cover,
                    loadingBuilder: onImageLoading,
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_alarm,
                                  color: Colors.white),
                              const SizedBox(
                                width: 10,
                              ),
                              CountdownTimer(
                                endTime: DateTime.now().millisecondsSinceEpoch + widget.auctionData.timeRemain,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(0.0, 5.0),
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.auctionData.productName, style: const TextStyle(fontSize: 24, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 5,),
                          // const StarRatingBar(rating: 5.0, size: 24),
                        ],
                      ),
                    ],
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
