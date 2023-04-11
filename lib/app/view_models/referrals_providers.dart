import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/bank_model.dart';
import 'package:fwheirs/app/models/referral_model.dart';

import '../../base/constant.dart';
import '../../dependency_injection/locator.dart';
import '../../local_storage/local_db.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../models/payout_account_model.dart';

class ReferralsProvider extends ChangeNotifier {
  BankModel selectedBank = BankModel();

  List<ReferralModel> referrals = [];
  List<PayoutAccountModel> payoutAccounts = [];
  // List<> referralEarnings = [];
  List<BankModel> banks = [];
  List<String> bankNames = [];

  // Add Bank Details
  GlobalKey<FormState> addBankFormKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankCodeNoController = TextEditingController();

  // Withdrawal Request

  void setSelectedBank(String newValue) {
    selectedBank =
        banks.where((BankModel element) => element.name == newValue).first;
    // setMinMaxVest();
    notifyListeners();
  }

  void setBankNames() {
    bankNames.clear();
    for (var bank in banks) {
      bankNames.add(bank.name.toString());
    }
  }

  Future<void> getPayoutAccounts(BuildContext context) async {
    try {
      print('Getting Payout Banks...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.get(
        "${Constant.liveUrl}/payout-account",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Payout Banks Gotten Successfully");
      print("GetPayoutBanks Response => ${response.data}");
      List tempAccounts = response.data['data'];
      payoutAccounts.clear();
      for (var bank in tempAccounts) {
        payoutAccounts.add(PayoutAccountModel.fromJson(bank));
      }
      print("MyPayoutBanks List => $payoutAccounts");
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

  Future<void> getReferrals(BuildContext context) async {
    try {
      print('Getting Referrals...');
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return LoadingDialog();
      //   },
      // );
      Dio dio = Dio();
      var response = await dio.get(
        "${Constant.liveUrl}/referral",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Referrals Gotten Successfully");
      print("GetReferrals Response => ${response.data}");
      List tempReferrals = response.data['data'];
      referrals.clear();
      for (var referral in tempReferrals) {
        referrals.add(ReferralModel.fromJson(referral));
      }
      print("MyReferrals List => $referrals");
      // investments = response.data['data'];
      notifyListeners();
      // Navigator.of(context, rootNavigator: true).pop(context);
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      // Navigator.of(context, rootNavigator: true).pop(context);
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

  Future<void> verifyAccount(BuildContext context) async {
    if (accountNumberController.text.length < 10) {
      accountNameController.clear();
      return;
    }
    print("==== get account name ====");
    try {
      accountNameController.clear();
      print('Getting Account Name...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      print(
          "${Constant.liveUrl}/account/validate?account_number=${accountNumberController.text}&bank_code=${selectedBank.code}");
      var response = await dio.get(
        "${Constant.liveUrl}/account/validate?account_number=${accountNumberController.text}&bank_code=${selectedBank.code}",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Account verification done");
      print("Account Verification Response => ${response.data}");

      accountNameController.text = response.data['data']['accountName'];

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
            text:
                'error: Account with such details was not found.\nPlease check bank name and account number again.',
          );
        },
      );
    }
  }

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
        "${Constant.liveUrl}/banklist",
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
      banks.clear();
      for (var bank in tempBanks) {
        banks.add(BankModel.fromJson(bank));
      }
      print("MyBanks List => $payoutAccounts");
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
      print('Adding Bank => ${"${Constant.liveUrl}/payout-account"}');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {
        "bank_name": selectedBank.name ?? bankNames[0],
        "account_number": accountNumberController.text,
        "account_name": accountNameController.text,
        "bank_code": selectedBank.code ?? 0
      };
      print(body);
      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/payout-account",
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
      print("MyBanks List => $payoutAccounts");
      // investments = response.data['data'];
      notifyListeners();
      getPayoutAccounts(context);

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
      print('Deleting Bank => ${"${Constant.liveUrl}/payout-account/$id"}');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.delete(
        "${Constant.liveUrl}/payout-account/$id",
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
      payoutAccounts.removeWhere((element) => element.id == id);
      print("MyBanks List => $payoutAccounts");
      // investments = response.data['data'];
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
      getPayoutAccounts(context);
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

  Future<void> makeWithdrawal(BuildContext context,
      {required String id}) async {
    try {
      print('Deleting Bank...');
      print('Deleting Bank => ${"${Constant.liveUrl}/payout-account/$id"}');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.delete(
        "${Constant.liveUrl}/payout-account/$id",
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
      payoutAccounts.removeWhere((element) => element.id == id);
      print("MyBanks List => $payoutAccounts");
      // investments = response.data['data'];
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
      getPayoutAccounts(context);
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
