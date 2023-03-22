import 'package:fwheirs/app/view/bankDetail/bank_detail.dart';
import 'package:fwheirs/app/view/history/history_screen.dart';
import 'package:fwheirs/app/view/home/detail_screen.dart';
import 'package:fwheirs/app/view/home/exchange_screen.dart';
import 'package:fwheirs/app/view/home/home_screen.dart';
import 'package:fwheirs/app/view/home/portfolio_screen.dart';
import 'package:fwheirs/app/view/home/market_trend_screen.dart';
import 'package:fwheirs/app/view/home/tab/tab_market.dart';
import 'package:fwheirs/app/view/intro/intro_screen.dart';
import 'package:fwheirs/app/view/login/change_password.dart';
import 'package:fwheirs/app/view/login/forgot_password.dart';
import 'package:fwheirs/app/view/login/login_screen.dart';
import 'package:fwheirs/app/view/price_alert/alert_create_screen.dart';
import 'package:fwheirs/app/view/price_alert/create_price_alert.dart';
import 'package:fwheirs/app/view/price_alert/price_alert_screen.dart';
import 'package:fwheirs/app/view/profile/edit_profile.dart';
import 'package:fwheirs/app/view/profile/my_profile.dart';
import 'package:fwheirs/app/view/setting/help_screen.dart';
import 'package:fwheirs/app/view/setting/privacy_screen.dart';
import 'package:fwheirs/app/view/setting/setting_screen.dart';
import 'package:fwheirs/app/view/signup/select_country.dart';
import 'package:fwheirs/app/view/signup/signup_screen.dart';
import 'package:fwheirs/app/view/signup/verify_screen.dart';
import 'package:fwheirs/app/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.forgotRoute: (context) => const ForgotPassword(),
    Routes.changePasswordRoute: (context) => const ChangePassword(),
    Routes.signUpRoutes: (context) => const SignUpScreen(),
    Routes.selectCountryRoute: (context) => const SelectCountry(),
    Routes.verifyRoute: (context) => const VerifyScreen(),
    Routes.homeScreenRoute: (context) => const HomeScreen(),
    Routes.portfolioRoute: (context) => const PortfolioScreen(),
    Routes.marketTrendRoute: (context) => const MarketTrendScreen(),
    Routes.detailRoute: (context) => const DetailScreen(),
    Routes.exchangeRoute: (context) => const ExchangeScreen(),
    Routes.myProfileRoute: (context) => const MyProfile(),
    Routes.editProfileRoute: (context) => const EditProfile(),
    Routes.bankDetailRoute: (context) => const BankDetail(),
    Routes.historyRoute: (context) => const HistoryScreen(),
    Routes.settingRoute: (context) => const SettingScreen(),
    Routes.priceAlertRoute: (context) => const PriceAlertScreen(),
    Routes.createPriceAlertRoute: (context) => const CreatePriceAlert(),
    Routes.helpScreenRoute: (context) => const HelpScreen(),
    Routes.privacyScreenroute: (context) => const PrivacyScreen(),
    Routes.alertCreateRoute: (context) => const AlertCreateScreen(),
    Routes.tabMarketRoute: (context) => const TabMarket()
  };
}
