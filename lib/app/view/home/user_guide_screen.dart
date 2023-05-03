import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/broker_model.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/investment_model.dart';

class UserGuideScreen extends StatefulWidget {
  final InvestmentModel investment;
  const UserGuideScreen({Key? key, required this.investment}) : super(key: key);

  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> {
  BrokerModel currentBroker = BrokerModel();
  void getBroker() {
    print(widget.investment.broker);
    print(Provider.of<InvestmentProvider>(context, listen: false).brokers);
    currentBroker = Provider.of<InvestmentProvider>(context, listen: false)
        .brokers
        .where((element) => element.name == widget.investment.broker)
        .first;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBroker();
  }

  @override
  Widget build(BuildContext context) {
    getBroker();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Broker's User Guide",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        elevation: 0,
        leading: getPaddingWidget(
          EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
          GestureDetector(
            child: getSvgImage("back.svg"),
            onTap: () {
              Constant.backToPrev(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(20),
            getMediumCustomFont(
                context, "${widget.investment.broker} User's Guide",
                fontSize: 18),
            getVerSpace(15),
            getMediumCustomFont(context, "${currentBroker.descr1}"),
            getVerSpace(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                getMediumCustomFont(
                    context, "Broker Name: ${currentBroker.name}"),
              ],
            ),
            getVerSpace(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                getMediumCustomFont(context,
                    "Default Password: ${widget.investment.defaultPassword ?? "Not Available"}"),
              ],
            ),
            getVerSpace(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                getMediumCustomFont(
                  context,
                  "User Email: ${Provider.of<ProfileProvider>(context, listen: false).myProfileInfo.email}",
                ),
              ],
            ),
            getVerSpace(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                GestureDetector(
                  onTap: () async {
                    print("Android Link: ${currentBroker.androidLink}");
                    await launchUrl(
                      Uri.parse("${currentBroker.androidLink}"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: getMediumCustomFont(
                    context,
                    "Android Mobile App",
                    fontColor: Colors.blue,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            getVerSpace(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                GestureDetector(
                  onTap: () {
                    print("iOS Link: ${currentBroker.iosLink}");
                    launchUrl(
                      Uri.parse("${currentBroker.iosLink}"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: getMediumCustomFont(
                    context,
                    "iOS Mobile App",
                    fontColor: Colors.blue,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            getVerSpace(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 7,
                ),
                getHorSpace(5),
                GestureDetector(
                  onTap: () {
                    print("Web Link: ${currentBroker.webLink}");
                    launchUrl(
                      Uri.parse("${currentBroker.webLink}"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: getMediumCustomFont(
                    context,
                    "Visit Website",
                    fontColor: Colors.blue,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            getVerSpace(10),
          ],
        ),
      ),
    );
  }
}
