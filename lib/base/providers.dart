import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:provider/provider.dart';

var providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => InvestmentProvider()),
];
