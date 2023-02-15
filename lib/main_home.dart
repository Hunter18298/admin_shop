import 'package:flutter/material.dart';
import 'package:online_shop_admin/utils/drawer.dart';

import 'screens/home_screen.dart';
import 'screens/order_screen.dart';
import 'screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Titles {
  home,
  services,
  categories,
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List _listOfPages = [];
  Widget? _currentPage;
  @override
  void initState() {
    _listOfPages
      ..add(HomeScreen())
      ..add(const ProfileScreen());

    _currentPage = HomeScreen();
    super.initState();
  }

//lo hiani index y pagakan lanaw aw list ay sare ka drustman krdia
//pesh u pash y pe bka loway bgordre
  void _getCurrentPage(int selectedindex) {
    setState(() {
      _currentIndex = selectedindex;
      _currentPage = _listOfPages[selectedindex];
    });
  }

  String? _getTitleName() {
    switch (_currentIndex) {
      case 0:
        return "Home";

      case 1:
        return "Cart";

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF0081C9),
                Color(0xFF5BC0F8),
                Color(0xFF86E5FF),
              ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              )),
        ),
        toolbarHeight: size.height * 0.07,
        elevation: 0,
        title: Text(_getTitleName() ?? "Home"),
        centerTitle: true,
      ),
      body: SafeArea(child: _currentPage!),
      bottomNavigationBar: SizedBox(
        height: size.width < 600 ? size.height * 0.099 : size.height * 0.2,
        child: Container(
          clipBehavior: Clip.hardEdge,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xFF0081C9),
                Color(0xFF5BC0F8),
                Color(0xFF86E5FF),
              ]),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100))),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black54,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) => _getCurrentPage(index),
            items: const [
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home_max),
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: "Cart"),
            ],
          ),
        ),
      ),
    );
  }
}
