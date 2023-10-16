import 'dart:convert';

import 'package:bidbay_mobile/common/values.dart';
import 'package:bidbay_mobile/models/yard_simple.dart';
import 'package:bidbay_mobile/view/login.dart';
import 'package:bidbay_mobile/widgets/content_title.dart';
import 'package:bidbay_mobile/widgets/yard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../cubit/authentication_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<YardSimple> yards = [
    YardSimple('1', 'Áo quần giày dép', 'Giá rẻ', 'District', '02d 15h 10m', '', 100, ['https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/95dc4c8a-5984-4737-b556-925fb2668247.jpg?alt=media']),
    YardSimple('1', 'Áo quần giày dép', 'Giá rẻ', 'District', '02d 15h 10m', '', 100, ['https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/95dc4c8a-5984-4737-b556-925fb2668247.jpg?alt=media']),
    YardSimple('1', 'Áo quần giày dép', 'Giá rẻ', 'District', '02d 15h 10m', '', 100, ['https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/95dc4c8a-5984-4737-b556-925fb2668247.jpg?alt=media']),
    YardSimple('1', 'Áo quần giày dép', 'Giá rẻ', 'District', '02d 15h 10m', '', 100, ['https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/95dc4c8a-5984-4737-b556-925fb2668247.jpg?alt=media']),
    YardSimple('1', 'Áo quần giày dép', 'Giá rẻ', 'District', '02d 15h 10m', '', 100, ['https://firebasestorage.googleapis.com/v0/b/bidbay-project.appspot.com/o/95dc4c8a-5984-4737-b556-925fb2668247.jpg?alt=media'])
  ];


  @override
  void initState(){
    super.initState();
    //addWebsocketListener();
    //readJson();
  }

  @override
  Widget build(BuildContext context) {
    return buildHomePage();
  }

  // void addWebsocketListener() {
  //   MyStompService stompService = MyStompService.getInstance();
  //   stompService.addListenerCallback('/topic/specific-user/$USER_ID', (frame) async {
  //     print("Got websocket message");
  //     final cubit = BlocProvider.of<IncomingMatchCubit>(context);
  //     cubit.getIncomingMatches();
  //     Fluttertoast.showToast(
  //       msg: frame.body!,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Color.fromARGB(255, 0, 255, 115),
  //       textColor: Color.fromARGB(255, 0, 0, 0),
  //       fontSize: 16.0
  //     );
  //   });
  // }

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
        title: Text('Bidbay'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                handleLogout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              const Text('Đấu giá ngay...', style: headerStyle),
              const SizedBox(height: 10),
              //const ContentTitle(title: 'Top Rating Yards'),
              SizedBox(
                height: 10,
              ),
              buildStaticYardList(),
              const ContentTitle(title: 'Đang diễn ra...'),
              buildStaticYardList(),
              //DistrictProvinceSelection(key: UniqueKey(),),
              SizedBox(
                height: 10,
              ),
              //buildYardList(),
            ],
          ),
        ),
      ),
    );
  }

   Widget buildStaticYardList() {
    //final yardListStaticCubit = BlocProvider.of<YardListStaticCubit>(context);
    //yardListStaticCubit.getYardList(null, null);

    // return BlocBuilder<YardListStaticCubit, YardListStaticState>(
    //   builder: (context, state){
    //     if(state is LoadingYardListStaticState) {
    //       return Loading();
    //     }
    //     if(state is LoadedYardListStaticState) {
    //       yards = state.yards;
    //     }

        return Column(
          children: [
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: yards.length,
                itemBuilder: (BuildContext context, int index) {
                  return YardCard(yard: yards[index]);
                },
              ),
            ),
          ],
        );
      }
  }

  // Widget buildYardList() {
  //   final yardListCubit = BlocProvider.of<YardListCubit>(context);
  //   yardListCubit.getYardList(null, null);

  //   return BlocBuilder<YardListCubit, YardListState>(
  //     builder: (context, state){
  //       if(state is LoadingYardListState) {
  //         return Loading();
  //       }
  //       if(state is LoadedYardListState) {
  //         yards = state.yards;
  //       }

  //       return Column(
  //         children: [
  //           SizedBox(
  //             height: 350,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               physics: const BouncingScrollPhysics(),
  //               itemCount: yards.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return YardCard(yard: yards[index]);
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     }
  //   );
  // }
//}
