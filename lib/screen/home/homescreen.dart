import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/screen/account/account_screen.dart';
import 'package:fregies/screen/favourite/favourite_screen.dart';
import 'package:fregies/screen/home/components/body.dart';
import 'package:fregies/screen/transaction/transaction_screen.dart';
import 'package:fregies/widgets/drawer_side_nav/drawer.dart';

class HomeScreen extends StatefulWidget {
  int setPage;
  HomeScreen({Key? key, this.setPage = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [
    const Body(),
    const FavouriteScreen(),
    const TransactionScreen(),
    const AccountScreen(),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widget.setPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.setPage,
        onTap: (int value) {
          setState(() {
            widget.setPage = value;
          });
        },
        selectedItemColor: lightPrimary,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(0.2),
        backgroundColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: const Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Transaction',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Profile',
          ),
        ],
      ),
      drawer: CustomDraw(),
    );
  }
}
