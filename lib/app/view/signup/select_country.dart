import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_country.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';

import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  void finishView() {
    Constant.backToPrev(context);
  }

  TextEditingController searchController = TextEditingController();
  List<ModelCountry> newCountryList = List.from(DataFile.countryList);

  onItemChanged(String value) {
    setState(() {
      newCountryList = DataFile.countryList
          .where((string) =>
              string.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(26)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  gettoolbarMenu(context, "back.svg", () {
                    finishView();
                  },
                      istext: true,
                      title: "Select Country",
                      weight: FontWeight.w700,
                      fontsize: 24,
                      textColor: Colors.black),
                ),
                getVerSpace(FetchPixels.getPixelHeight(18)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  getSearchWidget(
                      context, searchController, () {}, onItemChanged,
                      withPrefix: true),
                ),
                getVerSpace(FetchPixels.getPixelHeight(32)),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelHeight(20)),
                    scrollDirection: Axis.vertical,
                    itemCount: newCountryList.length,
                    itemBuilder: (context, index) {
                      ModelCountry modelCountry = newCountryList[index];
                      return GestureDetector(
                        onTap: () {
                          PrefData.setImage(modelCountry.image ?? "");
                          PrefData.setCode(modelCountry.code ?? "");
                          finishView();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: FetchPixels.getPixelHeight(20)),
                          height: FetchPixels.getPixelHeight(56),
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelHeight(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: containerShadow,
                                    blurRadius: 18,
                                    offset: const Offset(0, 4)),
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getAssetImage(
                                    modelCountry.image ?? '',
                                  ),
                                  getHorSpace(FetchPixels.getPixelHeight(12)),
                                  getCustomFont(modelCountry.name ?? "", 15,
                                      Colors.black, 1,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              Row(
                                children: [
                                  getCustomFont(modelCountry.code ?? "", 15,
                                      Colors.black, 1,
                                      fontWeight: FontWeight.w600)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
