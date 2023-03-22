import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../base/constant.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';

class InvestmentProvider extends ChangeNotifier {
  List investments = [];

  Future<void> getInvestments(BuildContext context) async {
    try {
      print('Getting Investments...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/invest",
      );
      Navigator.of(context, rootNavigator: true).pop(context);
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'error: ${e.message}',
          );
        },
      );
    }
  }
}
