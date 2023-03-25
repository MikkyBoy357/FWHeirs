import 'package:fwheirs/app/models/intro_model.dart';
import 'package:fwheirs/app/models/model_chartdata.dart';
import 'package:fwheirs/app/models/model_country.dart';
import 'package:fwheirs/app/models/model_currency.dart';
import 'package:fwheirs/app/models/model_history.dart';
import 'package:fwheirs/app/models/model_news.dart';
import 'package:fwheirs/app/models/model_payment.dart';
import 'package:fwheirs/app/models/model_portfolio.dart';

import '../../base/color_data.dart';
import '../models/model_item.dart';
import '../models/model_price_alert.dart';
import '../models/model_trend.dart';

class DataFile {
  static List<ModelIntro> introList = [
    ModelIntro(
        1,
        intro1,
        "intro1.png",
        "Profitable Forex",
        "Get started with trading forex profitably without necessarily possessing advanced knowledge of how trading works.",
        "Next"),
    ModelIntro(
        2,
        intro2,
        "intro2.png",
        "Grow your Money",
        "Consistently grow your portfolio using our sophisticated forex minter.",
        "Next"),
    ModelIntro(
        3,
        intro3,
        "intro3.png",
        "Be an Expert",
        "Whether you are new to forex or not, be confident of getting results like an Expert.",
        "Get Started"),
  ];

  static List<ModelCountry> countryList = [
    ModelCountry("image_fghanistan.jpg", "Afghanistan (AF)", "+93"),
    ModelCountry("image_ax.jpg", "Aland Islands (AX)", "+358"),
    ModelCountry("image_albania.jpg", "Albania (AL)", "+355"),
    ModelCountry("image_andora.jpg", "Andorra (AD)", "+376"),
    ModelCountry("image_islands.jpg", "Aland Islands (AX)", "+244"),
    ModelCountry("image_angulia.jpg", "Anguilla (AL)", "+1"),
    ModelCountry("image_armenia.jpg", "Armenia (AN)", "+374"),
    ModelCountry("image_austia.jpg", "Austria (AT)", "+372"),
  ];

  static List<ModelItem> itemList = [
    ModelItem("home.svg", "Home"),
    ModelItem("exchange.svg", "History"),
    ModelItem("chart.svg", "Referral"),
    ModelItem("profile.svg", "More")
  ];

  static List<ModelPortfolio> portfolioList = [
    ModelPortfolio("btc.svg", "Exness", "-0.22", 56.33, "BTS"),
    ModelPortfolio("eth.svg", "Hantec", "+0.22", 25.56, "ETH"),
    ModelPortfolio("eur.svg", "Exness", "-0.36", 69.25, "EUR"),
    ModelPortfolio("ltc.svg", "Hantec", "+0.35", 33.53, "LIT"),
    ModelPortfolio("eur.svg", "Exness", "-0.45", 74.52, "EUR"),
    ModelPortfolio("bnb.svg", "Hantec", "+0.35", 26.53, "BIN"),
    ModelPortfolio("usd.svg", "Exness", "-0.24", 74.52, "UNI")
  ];

  static List<ModelTrend> trendList = [
    ModelTrend("eur.svg", "European Union", "EUR", 56.55, "2.4%"),
    ModelTrend("usd.svg", "United States Dollar", "USD", 21.42, "-1.3%"),
    ModelTrend("bnb.svg", "Binance Coin", "BNB", 26.76, "4.3%"),
    ModelTrend("ltc.svg", "Litecoin", "LTC", 45.23, "-2.4%"),
    ModelTrend("eth.svg", "Ethereum", "ETH", 78.35, "5.6%"),
    ModelTrend("btc.svg", "Bitcoin", "BTC", 75.24, "-6.5%"),
    ModelTrend("usd.svg", "United States Dollar", "USD", 45.23, "8.3%")
  ];

  static List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53, 3.3),
    ChartData(2011, 9.5, 5.4),
    ChartData(2012, 10, 2.65),
    ChartData(2013, 9.4, 2.62),
    ChartData(2014, 5.8, 1.99),
    ChartData(2015, 4.9, 1.44),
    ChartData(2016, 4.5, 2),
    ChartData(2017, 3.6, 1.56),
    ChartData(2018, 3.43, 2.1),
  ];

  static List<ModelNews> newsList = [
    ModelNews("new1.png", "NFTs: the future of fine art? "),
    ModelNews("new2.png", "Creative circle waves digital art"),
  ];

  static List<String> categoryList = [
    "Info",
    "People",
    "Commission",
    // "Trending"
  ];

  static List<ModelPayment> paymentList = [
    ModelPayment("paypal.svg", "Paypal", "xxxx xxxx xxxx 5416"),
    ModelPayment("mastercard.svg", "Master Card", "xxxx xxxx xxxx 8624"),
    ModelPayment("visa.svg", "Visa", "xxxx xxxx xxxx 4565"),
  ];

  static List<ModelHistory> historyList = [
    ModelHistory(
        "history1.png", "Received BTC", "0.22 BTC", "16 July, 2022", "\$56.00"),
    ModelHistory("history2.png", "Purchased BTC", "0.00254 BTC",
        "12 July, 2022", "\$56.00"),
    ModelHistory("history2.png", "Purchased BTC", "0.145 BTC", "10 July, 2022",
        "\$76.33"),
    ModelHistory("history2.png", "Purchased BTC", "0.00254 BTC",
        "12 July, 2022", "\$42.32"),
    ModelHistory("history2.png", "Purchased BTC", "0.145 BTC", "10 July, 2022",
        "\$76.00"),
    ModelHistory(
        "history3.png", "INR Deposit+", "0.22 BTC", "Failed", "Need Help?"),
    ModelHistory(
        "history1.png", "Received BTC", "0.14 BTC", "08 July, 2022", "\$56.32"),
  ];

  static List<ModelCurrency> currencyList = [
    ModelCurrency("btc.svg", "Bitcoin"),
    ModelCurrency("eth.svg", "Ethereum"),
    ModelCurrency("eur.svg", "European Unicon"),
    ModelCurrency("ltc.svg", "Litecoin"),
    ModelCurrency("eur.svg", "European Unicon"),
    ModelCurrency("bnb.svg", "Binance Coin"),
    ModelCurrency("usd.svg", "United States Dollar")
  ];

  static List<ModelPriceAlert> priceAlertList = [
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$575.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$386.02"),
    ModelPriceAlert("btc.svg", "Bitcoin", "Price rises to", "\$785.02"),
    ModelPriceAlert("eth.svg", "Ethereum", "Price rises to", "\$547.02")
  ];
}
