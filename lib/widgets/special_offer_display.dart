import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/widgets/special_offer_card.dart';

Container specialOfferDisplay(specialOfferList) {
  return Container(
    //color: Colors.red,
    height: getPercentageHeight(15),
    width: getPercentageWidth(100),
    padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialOfferList.length,
        itemBuilder: (_, index) {
          return SpecialOfferCard(specialOffer: specialOfferList[index]);
        }),
  );
}
