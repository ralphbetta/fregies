import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/config/theme_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/screen/product_details/product_detail_screen.dart';
import 'package:provider/src/provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      height: getPercentageWidth(12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: searchController,
        onTap: () {
          showSearch(context: context, delegate: DataSearch());
        },
        decoration: InputDecoration(
            hintText: "Search Groceries",
            contentPadding: EdgeInsets.only(top: 9),
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_outlined,
              color: Theme.of(context).hintColor,
            )),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // TODO: implement appBarTheme
    return Theme.of(context).copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        fillColor: theme.backgroundColor,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  InputDecorationTheme? get searchFieldDecorationTheme =>
      const InputDecorationTheme(
        border: InputBorder.none,
      );

  final List<ProductModel> recentProduct = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentProduct
        : context
            .watch<List<ProductModel>>()
            .where((element) =>
                element.category.toLowerCase().startsWith(query) ||
                element.product.toLowerCase().startsWith(query))
            .toList();
    return ProductDetailScreen(product: productDB[1]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentProduct
        : context
            .watch<List<ProductModel>>()
            .where((element) =>
                element.category.toLowerCase().startsWith(query) ||
                element.product.toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              //showResults(context);
              reversibleNavigation(
                  context, ProductDetailScreen(product: suggestionList[index]));
            },
            leading: Container(
              width: getPercentageWidth(20),
              height: getPercentageWidth(20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: lightPrimary)),
              child: Image(
                image: NetworkImage(suggestionList[index].image),
              ),
            ),
            title: RichText(
                text: TextSpan(
                    text: suggestionList[index]
                        .product
                        .substring(0, query.length),
                    style: const TextStyle(color: lightPrimary),
                    children: [
                  TextSpan(
                      text:
                          suggestionList[index].product.substring(query.length),
                      style: TextStyle(color: kTextColor))
                ])),
            subtitle: Text(suggestionList[index].category),
          );
        });
  }
}
