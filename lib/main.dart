import 'package:bidbay_mobile/bloc_providers.dart';
import 'package:bidbay_mobile/service/auction_service.dart';
import 'package:bidbay_mobile/view/home_view.dart';
import 'package:bidbay_mobile/view/login.dart';
import 'package:bidbay_mobile/view/signup.dart';
import 'package:bidbay_mobile/view/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:bidbay_mobile/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  AuctionService auctionService = getIt<AuctionService>();
  auctionService.getBrands();
  auctionService.getCategories(); 
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.getProviders,
      child: MaterialApp(
        title: 'Basketball Yard Booking System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: LoginScreen.routeName, // Set the initial route
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          VerifyOtpPage.routeName: (context) => VerifyOtpPage(),
          MyHomePage.routeName: (context) => const MyHomePage(title: 'Basketball Yard Booking System'),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        HomePage(key: UniqueKey()),
        HomePage(key: UniqueKey()),
        HomePage(key: UniqueKey()),
        HomePage(key: UniqueKey()),
        // ListPage(
        //   key: listStateKey,
        // ),
      ]),
      bottomNavigationBar:
          buildBottomAppBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget buildBottomAppBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      backgroundColor: Color.fromARGB(226, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(223, 22, 21, 21),
      selectedItemColor: Color.fromARGB(223, 41, 47, 242),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Đã mua'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Thông báo'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
      ],
    );
  }
}
