import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../base/constant.dart';
import '../../dependency_injection/locator.dart';
import '../../local_storage/local_db.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../models/bank_model.dart';

class ReferralsProvider extends ChangeNotifier {
  List<BankModel> myBanks = [];

  // Add Bank Details
  GlobalKey<FormState> addBankFormKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankCodeNoController = TextEditingController();

  Future<void> getBanks(BuildContext context) async {
    try {
      print('Getting Banks...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.get(
        "${Constant.liveUrl}/bank",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Banks Gotten Successfully");
      print("GetBanks Response => ${response.data}");
      List tempBanks = response.data['data'];
      myBanks.clear();
      for (var bank in tempBanks) {
        myBanks.add(BankModel.fromJson(bank));
      }
      print("MyBanks List => $myBanks");
      // investments = response.data['data'];
      notifyListeners();
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

  Future<void> addBank(BuildContext context) async {
    try {
      print('Adding Bank...');
      print('Adding Bank => ${"${Constant.liveUrl}/bank"}');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {
        "bank_name": bankNameController.text,
        "account_number": accountNumberController.text,
        "account_name": accountNameController.text,
        "bank_code": bankCodeNoController.text
      };
      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/bank",
        data: body,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Bank ${bankNameController.text} added Successfully");
      print("AddBank Response => ${response.data}");
      print("MyBanks List => $myBanks");
      // investments = response.data['data'];
      notifyListeners();
      getBanks(context);

      Navigator.of(context, rootNavigator: true).pop(context);
      Navigator.pop(context);
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

  Future<void> deleteBank(BuildContext context, {required String id}) async {
    try {
      print('Deleting Bank...');
      print('Deleting Bank => ${"${Constant.liveUrl}/bank/$id"}');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.delete(
        "${Constant.liveUrl}/bank/$id",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Bank id $id deleted Successfully");
      print("DeleteBanks Response => ${response.data}");
      myBanks.removeWhere((element) => element.id == id);
      print("MyBanks List => $myBanks");
      // investments = response.data['data'];
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
      getBanks(context);
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
