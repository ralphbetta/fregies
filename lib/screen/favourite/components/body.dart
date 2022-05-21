import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/widgets/advert_banner.dart';
import 'package:fregies/widgets/display_divider.dart';
import 'package:fregies/widgets/favourite_product_display.dart';
import 'package:fregies/widgets/green_appbar.dart';
import 'package:fregies/widgets/home_appbar.dart';
import 'package:fregies/widgets/horizontal_line.dart';
import 'package:fregies/widgets/linear_display.dart';
import 'package:fregies/widgets/searchbar_container.dart';
import 'package:fregies/widgets/special_offer_display.dart';
import 'package:fregies/widgets/tabbar_container.dart';
import 'package:fregies/widgets/tap_product_display.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  int activeCat = 0;

  List favCatList = [
    {"title": "All", "image": "assets/icons/cat2.png"},
    {"title": "Fruits", "image": "assets/icons/cat1.png"},
    {"title": "Vegetable", "image": "assets/icons/cat3.png"},
    {"title": "Dried", "image": "assets/icons/cat4.png"},
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);

    return Scaffold(
      appBar: greenAppbar(context, "My Favourites"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: getPercentageHeight(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: lightPrimary,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getPercentageWidth(10)),
                      width: double.infinity,
                      height: getPercentageWidth(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search Groceries",
                            contentPadding: EdgeInsets.only(top: 12),
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: Theme.of(context).hintColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getPercentageWidth(5),
                    vertical: getPercentageHeight(1)),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                          4,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activeCat = index;
                                  });
                                },
                                child: FavouriteCategories(
                                  selected: activeCat == index ? true : false,
                                  favCatList: favCatList[index],
                                  currentIndex: index,
                                ),
                              ))
                    ],
                  ),
                ),
              ),
              const horizontalLine(),
              SizedBox(
                height: getPercentageHeight(56),
                width: double.infinity,
                child: FavouriteProductDisplay(
                  category: favCatList[activeCat]['title'],
                  all: activeCat == 0 ? true : false,
                ),
              ),
            ],
          ),
        ),
      ),
      //backgroundColor: ThemeMode,
    );
  }
}

class FavouriteCategories extends StatelessWidget {
  const FavouriteCategories({
    Key? key,
    required this.selected,
    required this.favCatList,
    required this.currentIndex,
  }) : super(key: key);

  final bool selected;
  final Map favCatList;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: selected ? lightPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(
              50,
            ),
            border: Border.all(width: 2, color: lightPrimary),
          ),
          child: Image(
            image: AssetImage(favCatList['image']),
            color: selected
                ? white
                : Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
        SizedBox(
          height: getPercentageHeight(1),
        ),
        Text(favCatList['title']),
      ],
    );
  }
}
