import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/widgets/advert_banner.dart';
import 'package:fregies/widgets/display_divider.dart';
import 'package:fregies/widgets/home_appbar.dart';
import 'package:fregies/widgets/linear_display.dart';
import 'package:fregies/widgets/searchbar_container.dart';
import 'package:fregies/widgets/special_offer_display.dart';
import 'package:fregies/widgets/tabbar_container.dart';
import 'package:fregies/widgets/tap_product_display.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  int currentAdvert = 0;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);

    // List<ProductModel> specialOfferList =
    //     productDB.where((element) => element.specialOffer == true).toList();

    List<ProductModel> specialOfferList = context
        .watch<List<ProductModel>>()
        .where((element) => element.specialOffer == true)
        .toList();

    return Scaffold(
      //backgroundColor: ThemeMode,
      appBar: homeAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(searchController: searchController),

            TabBarContainer(tabController: _tabController),
            //Tab view container
            Container(
              height: getPercentageHeight(65),
              //height: getPercentageHeight(61), //for emulator
              width: double.infinity,
              //padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
              child: TabBarView(controller: _tabController, children: [
                Container(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: getPercentageHeight(1),
                    ),

                    //this Sizedbox contends the advert banner
                    SizedBox(
                        width: getPercentageWidth(100),
                        height: getPercentageHeight(13),
                        child: PageView.builder(
                            itemCount: adverts.length,
                            onPageChanged: (value) {
                              setState(() {
                                currentAdvert = value;
                              });
                            },
                            itemBuilder: (_, index) {
                              return AdvertBanners(index: index);
                            })),

                    Container(
                        margin: EdgeInsets.only(top: getPercentageHeight(1)),
                        color: Theme.of(context).backgroundColor,
                        width: getPercentageWidth(100),
                        height: getPercentageHeight(3),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                adverts.length,
                                (index) => AdvertIndicator(
                                      active:
                                          currentAdvert == index ? true : false,
                                    ))
                          ],
                        ))),

                    const LinearProductDisplay(
                      sort: '',
                    ),

                    displayDivider(
                        context, "Special Offer", false, true, "View all"),

                    specialOfferDisplay(specialOfferList),

                    displayDivider(context, "Fruits", true, false, "View all"),
                    const LinearProductDisplay(
                      sort: 'Fruits',
                    ),

                    displayDivider(context, "Dried", true, false, "View all"),
                    const LinearProductDisplay(
                      sort: 'Drieds',
                    ),

                    displayDivider(
                        context, "Vegetables", true, false, "View all"),
                    const LinearProductDisplay(
                      sort: 'Vegetables',
                    ),
                    displayDivider(context, "Others", true, false, "View all"),
                    const LinearProductDisplay(
                      sort: 'Others',
                    ),
                  ],
                )),
                const SizedBox(
                  child: TapProductDisplay(
                    category: "Fruits",
                  ),
                ),
                const SizedBox(
                  child: TapProductDisplay(
                    category: "Vegetables",
                  ),
                ),
                const SizedBox(
                  child: TapProductDisplay(
                    category: "Drieds",
                  ),
                ),
                const SizedBox(
                  child: TapProductDisplay(
                    category: "Others",
                  ),
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
