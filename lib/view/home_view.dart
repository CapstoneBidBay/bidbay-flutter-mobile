import 'dart:async';

import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/cubit/auction_list_cubit.dart';
import 'package:bidbay_mobile/models/auction_simple_model.dart';
import 'package:bidbay_mobile/models/filter_model.dart';
import 'package:bidbay_mobile/view/login.dart';
import 'package:bidbay_mobile/widgets/auction_card.dart';
import 'package:bidbay_mobile/widgets/content_title.dart';
import 'package:bidbay_mobile/widgets/filter_form.dart';
import 'package:bidbay_mobile/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/authentication_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Auction> auctions = [];

  String searchKey = "";
  FilterData filterData = FilterData();

  Timer? _debounce;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildHomePage();
  }

  @override
  void dispose(){
    _debounce?.cancel();
    super.dispose();
  }

  Widget buildHomePage() {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future<void> handleLogout(BuildContext context) async {
      print("logout");
      //final storage = FlutterSecureStorage();
      //var token = await storage.read(key: JWT_STORAGE_KEY);
      var token = JWT_TOKEN_VALUE;
      await cubit.logout(token);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidbay'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                handleLogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              const Text('Đấu giá ngay...', style: headerStyle),
              const SizedBox(height: 10),
              buildSearchSection(),
              const SizedBox(
                height: 10,
              ),
              buildStaticYardList(),
              const ContentTitle(title: 'Đấu giá nổi bật...'),
              buildStaticYardList(),
              //DistrictProvinceSelection(key: UniqueKey(),),
              const SizedBox(
                height: 10,
              ),
              //buildYardList(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildSearchSection() {
    return Column(
      children: [
        SizedBox(
          child: TextField(
            onChanged: _onSearchChange,
            style: GoogleFonts.poppins(
              color: const Color(0xff020202),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            autofocus: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xfff1f1f1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: "Search for Items",
              hintStyle: GoogleFonts.poppins(
                  color: const Color(0xffb2b2b2),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  decorationThickness: 6),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed: (){
                showFilter();
              }, icon: const Icon(Icons.filter_list_alt), padding: const EdgeInsets.all(0), constraints: const BoxConstraints(),),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStaticYardList() {
    AuctionListStaticCubit auctionListStaticCubit = BlocProvider.of<AuctionListStaticCubit>(context);
    auctionListStaticCubit.getYardList(searchKey, filterData);

    return BlocBuilder<AuctionListStaticCubit, AuctionListStaticState>(
      builder: (context, state){
        if(state is LoadingAuctionListStaticState){
          return const Loading();
        }
        if(state is LoadedAuctionListStaticState){
          auctions = state.auctions;
        }
        return Column(
          children: [
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: auctions.length,
                itemBuilder: (BuildContext context, int index) {
                  return AuctionCard(auctionData: auctions[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

    void showFilter() {
      showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(19, 119, 127, 143),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FilterForm(onSubmit: onFilterSubmit, data: filterData)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
    }

    void onFilterSubmit(FilterData filterDataModel){
      setState(() {
        filterData = filterDataModel;
      });
      AuctionListStaticCubit auctionListStaticCubit = BlocProvider.of<AuctionListStaticCubit>(context);
      auctionListStaticCubit.getYardList(searchKey, filterDataModel);
      Navigator.of(context).pop();
    }
    void _onSearchChange(String query){
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 1500), () {
        AuctionListStaticCubit auctionListStaticCubit = BlocProvider.of<AuctionListStaticCubit>(context);
        auctionListStaticCubit.getYardList(query, filterData);
        setState(() {
          searchKey = query;
        });
      });
    }
  }