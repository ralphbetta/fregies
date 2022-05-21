import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/maps.dart';

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        //indicatorColor: lightPrimary,
        labelColor: lightPrimary,
        unselectedLabelColor: Theme.of(context).hintColor,
        controller: _tabController,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
              width: 3.0, color: lightPrimary, style: BorderStyle.solid),
          // insets:
          //     EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabList,
      ),
    );
  }
}
