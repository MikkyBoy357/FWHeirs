import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_history.dart';
import 'package:fwheirs/app/view/dialog/statement_dialog.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelHistory> historyLists = DataFile.historyList;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  getVerSpace(
                    FetchPixels.getPixelHeight(20),
                  ),
                  if (historyLists.isEmpty)
                    emptyWidget(context)
                  else
                    historyList()
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }

  Expanded historyList() {
    return Expanded(
        flex: 1,
        child: AnimationLimiter(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: historyLists.length,
            itemBuilder: (context, index) {
              ModelHistory modelHistory = historyLists[index];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 200),
                  child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                        onTap: () {
                          showDialog(
                              builder: (context) {
                                return const StatementDialog();
                              },
                              context: context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: horSpace),
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelHeight(16),
                              vertical: FetchPixels.getPixelHeight(16)),
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 23,
                                    offset: const Offset(0, 7))
                              ],
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(14))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getAssetImage(modelHistory.image ?? "",
                                      height: FetchPixels.getPixelHeight(50),
                                      width: FetchPixels.getPixelHeight(50)),
                                  getHorSpace(FetchPixels.getPixelHeight(14)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getMediumCustomFont(
                                        context,
                                        modelHistory.name ?? "",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(3)),
                                      getMediumCustomFont(
                                        context,
                                        modelHistory.btc ?? "",
                                        fontWeight: FontWeight.w400,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  getCustomFont(
                                      modelHistory.date ?? "",
                                      15,
                                      modelHistory.date == "Failed"
                                          ? error
                                          : textColor,
                                      1,
                                      fontWeight: FontWeight.w400),
                                  getVerSpace(FetchPixels.getPixelHeight(3)),
                                  getCustomFont(
                                      modelHistory.price ?? "",
                                      15,
                                      modelHistory.price == "Need Help?"
                                          ? blueColor
                                          : success,
                                      1,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                        ),
                      ))));
            },
          ),
        ));
  }

  Expanded emptyWidget(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage("browsers.svg"),
        getVerSpace(FetchPixels.getPixelHeight(26)),
        getCustomFont("No History Yet!", 20, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getMultilineCustomFont(
            "Go to crypto transaction and get started.", 16, Colors.black,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getButton(
            context, Colors.white, "Go to transaction", blueColor, () {}, 16,
            weight: FontWeight.w600,
            isBorder: true,
            borderColor: blueColor,
            borderWidth: FetchPixels.getPixelHeight(2),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelHeight(90)))
      ],
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: FetchPixels.getPixelHeight(66),
      leading: getPaddingWidget(
        EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(21)),
        GestureDetector(
          child: getSvgImage("back.svg"),
          onTap: () {
            backToPrev();
          },
        ),
      ),
      title: getCustomFont(
        "History",
        22,
        Theme.of(context).textTheme.bodyLarge!.color!,
        1,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
      actions: [
        Row(
          children: [
            getSvgImage("statement.svg"),
            getHorSpace(FetchPixels.getPixelHeight(1)),
            getCustomFont("STATEMENT", 16, blueColor, 1,
                fontWeight: FontWeight.w600),
            getHorSpace(FetchPixels.getPixelHeight(20))
          ],
        )
      ],
    );
  }
}
