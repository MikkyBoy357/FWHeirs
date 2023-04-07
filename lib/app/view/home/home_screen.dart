import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_item.dart';
import 'package:fwheirs/app/view/history/history_screen.dart';
import 'package:fwheirs/app/view/home/tab/tab_home.dart';
import 'package:fwheirs/app/view/home/tab/tab_market.dart';
import 'package:fwheirs/app/view/home/tab/tab_profile.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:provider/provider.dart';

import '../../../base/widget_utils.dart';
import '../../view_models/investment_providers/investment_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int position = 0;

  void close() {
    Constant.closeApp();
  }

  List<Widget> tabList = [
    const TabHome(),
    // const TabTransaction(),
    const HistoryScreen(),
    const TabMarket(),
    const TabProfile(),
  ];
  List<ModelItem> itemLists = DataFile.itemList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProfileProvider>(context, listen: false)
          .getProfileInfo(context);
      Provider.of<InvestmentProvider>(context, listen: false)
          .getInvestments(context);

      Provider.of<InvestmentProvider>(context, listen: false)
          .getBrokers(context);
      Provider.of<InvestmentProvider>(context, listen: false)
          .getPackages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: tabList[position],
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      height: Platform.isAndroid
          ? FetchPixels.getPixelHeight(66)
          : FetchPixels.getPixelHeight(86),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 23, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(itemLists.length, (index) {
          ModelItem modelItem = itemLists[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                position = index;
              });
            },
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(46),
                  width: FetchPixels.getPixelHeight(46),
                  decoration: position == index
                      ? BoxDecoration(
                          color: position == index
                              ? blueColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                              BoxShadow(
                                  color: shadowColor,
                                  blurRadius: 18,
                                  offset: const Offset(0, 9))
                            ])
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(FetchPixels.getPixelHeight(11)),
                    child: getSvgImage(modelItem.image ?? "",
                        color: position == index ? Colors.white : null),
                  ),
                ),
                position == index
                    ? Row(
                        children: [
                          getHorSpace(FetchPixels.getPixelHeight(8)),
                          getMediumCustomFont(context, modelItem.name ?? '')
                        ],
                      )
                    : Container()
              ],
            ),
          );
        }),
      ), // child:
    );
  }
}
